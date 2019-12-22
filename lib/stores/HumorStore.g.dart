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

  final _$addHumorAsyncAction = AsyncAction('addHumor');

  @override
  Future<void> addHumor(RegistroHumor humor) {
    return _$addHumorAsyncAction.run(() => super.addHumor(humor));
  }
}
