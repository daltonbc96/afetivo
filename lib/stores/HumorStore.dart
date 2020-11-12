import 'dart:async';

import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/models/Medicamento.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:afetivo/extensions/DateTime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'HumorStore.g.dart';

final _fireStore = Firestore.instance;

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
            .document(uid)
            .collection('humorEntries')
            .orderBy('data', descending: true)
            .snapshots()
            .listen((event) {
          humorList = ObservableList.of(event.documents.map((e) {
            var data = e.data;
            data["id"] = e.documentID;
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

  @observable
  bool filtered = false;

  @observable
  ObservableList<RegistroHumor> humorList = ObservableList();

  @computed
  ObservableList<RegistroHumor> get filteredHumors {
    var ret = humorList;

    if (filtered) {
      if (startDate != null)
        ret = ObservableList.of(
            ret.where((x) => x.data.isAfterOrAtDate(startDate)));

      if (endDate != null)
        ret = ObservableList.of(
            ret.where((x) => x.data.isBeforeOrAtDate(endDate)));
    }

    return ret;
  }

  @action
  void toggleFilter() {
    filtered = !filtered;
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
        .document(loginStore.uid)
        .collection("humorEntries")
        .document(humor.id)
        .setData(humor.toJson());
  }

  @action
  Future<void> deleteHumor(RegistroHumor humor) async {
    await _fireStore
        .collection("users")
        .document(loginStore.uid)
        .collection("humorEntries")
        .document(humor.id)
        .delete();
  }
}
