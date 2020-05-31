import 'dart:async';

import 'package:afetivo/models/Medicamento.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import '../models/Humor.dart';

part 'HumorStore.g.dart';

final _fireStore = Firestore.instance;

class HumorStore extends _HumorStore with _$HumorStore {
  StreamSubscription _snapshotsSubscription;
  ReactionDisposer _disposeLoginReactor;

  HumorStore({@required LoginStore loginStore})
      : super(loginStore: loginStore) {
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
  final LoginStore loginStore;

  _HumorStore({@required this.loginStore});

  @observable
  ObservableList<RegistroHumor> humorList = ObservableList();

  @action
  RegistroHumor createHumor(TipoHumor tipoHumor) {
    final humor = RegistroHumor(tipo: tipoHumor);
    if (loginStore.userProfile != null) {
      humor.medicamentos = ObservableList.of(loginStore.userProfile.medicamentos
          .map((med) => RegistroMedicamento(medicamento: med))
          .toList());
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
