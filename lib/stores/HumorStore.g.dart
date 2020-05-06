// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HumorStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HumorStore on _HumorStore, Store {
  final _$humorListAtom = Atom(name: '_HumorStore.humorList');

  @override
  ObservableList<RegistroHumor> get humorList {
    _$humorListAtom.context.enforceReadPolicy(_$humorListAtom);
    _$humorListAtom.reportObserved();
    return super.humorList;
  }

  @override
  set humorList(ObservableList<RegistroHumor> value) {
    _$humorListAtom.context.conditionallyRunInAction(() {
      super.humorList = value;
      _$humorListAtom.reportChanged();
    }, _$humorListAtom, name: '${_$humorListAtom.name}_set');
  }

  final _$editHumorAsyncAction = AsyncAction('editHumor');

  @override
  Future<void> editHumor(RegistroHumor humor) {
    return _$editHumorAsyncAction.run(() => super.editHumor(humor));
  }

  final _$deleteHumorAsyncAction = AsyncAction('deleteHumor');

  @override
  Future<void> deleteHumor(RegistroHumor humor) {
    return _$deleteHumorAsyncAction.run(() => super.deleteHumor(humor));
  }

  final _$_HumorStoreActionController = ActionController(name: '_HumorStore');

  @override
  RegistroHumor createHumor(TipoHumor tipoHumor) {
    final _$actionInfo = _$_HumorStoreActionController.startAction();
    try {
      return super.createHumor(tipoHumor);
    } finally {
      _$_HumorStoreActionController.endAction(_$actionInfo);
    }
  }
}
