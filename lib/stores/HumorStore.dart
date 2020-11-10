import 'dart:async';

import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/models/Medicamento.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:afetivo/extensions/DateTime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'HumorStore.g.dart';

final _fireStore = FirebaseFirestore.instance;

class HumorStore extends _HumorStore with _$HumorStore {
  StreamSubscription _snapshotsSubscription;
  ReactionDisposer _disposeLoginReactor;

  static HumorStore _instance;

  factory HumorStore() {
    if (_instance == null) _instance = HumorStore._();

    return _instance;
  }

  HumorStore._() {
    _disposeLoginReactor = autorun((_) async {
      final uid = loginStore.uid;
      if (_snapshotsSubscription != null) {
        await _snapshotsSubscription.cancel();
        _snapshotsSubscription = null;
      }
      if (uid != null)
        _snapshotsSubscription = _fireStore
            .collection('users')
            .doc(uid)
            .collection('humorEntries')
            .orderBy('data', descending: true)
            .snapshots()
            .listen((event) {
          humorList = ObservableList.of(event.docs.map((e) {
            var data = e.data();
            data["id"] = e.id;
            return RegistroHumor.fromJson(data);
          }).toList());
        }); // _snapshotsSubscription
      else
        humorList = ObservableList();
    }); // _disposeLoginReaction
  } // HumorStore

  void dispose() {
    _disposeLoginReactor();
  }
}

abstract class _HumorStore with Store {
  final LoginStore loginStore = LoginStore();

  @observable
  DateTime startDate;

  @observable
  DateTime endDate;

  @computed
  bool get filtered => startDate != null || endDate != null;

  @observable
  ObservableList<RegistroHumor> humorList = ObservableList();

  @computed
  ObservableList<RegistroHumor> get filteredHumors {
    var ret = humorList;

    if (startDate != null)
      ret = ObservableList.of(
          ret.where((x) => x.data.isAfterOrAtDate(startDate)));

    if (endDate != null)
      ret =
          ObservableList.of(ret.where((x) => x.data.isBeforeOrAtDate(endDate)));

    return ret;
  }

  @action
  void toggleFilter() {
    if (!filtered && humorList != null && humorList.length > 0) {
      startDate = humorList.last.data;
      endDate = humorList.first.data;
    } else {
      startDate = null;
      endDate = null;
    }
  }

  @action
  RegistroHumor createHumor(TipoHumor tipoHumor) {
    final humor = RegistroHumor(tipo: tipoHumor);
    if (loginStore.userProfile != null) {
      humor.medicamentos = ObservableList.of(loginStore.userProfile.medicamentos
          .map((med) => RegistroMedicamento(medicamento: med)));
    }

    return humor;
  }

  @action
  void editHumor(RegistroHumor humor) {
    _fireStore
        .collection("users")
        .doc(loginStore.uid)
        .collection("humorEntries")
        .doc(humor.id)
        .set(humor.toJson());
  }

  @action
  Future<void> deleteHumor(RegistroHumor humor) async {
    await _fireStore
        .collection("users")
        .doc(loginStore.uid)
        .collection("humorEntries")
        .doc(humor.id)
        .delete();
  }
}
