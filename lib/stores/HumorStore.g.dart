// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HumorStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HumorStore on _HumorStore, Store {
  Computed<ObservableList<RegistroHumor>> _$filteredHumorsComputed;

  @override
  ObservableList<RegistroHumor> get filteredHumors =>
      (_$filteredHumorsComputed ??= Computed<ObservableList<RegistroHumor>>(
              () => super.filteredHumors,
              name: '_HumorStore.filteredHumors'))
          .value;

  final _$startDateAtom = Atom(name: '_HumorStore.startDate');

  @override
  DateTime get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  final _$endDateAtom = Atom(name: '_HumorStore.endDate');

  @override
  DateTime get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(DateTime value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  final _$filteredAtom = Atom(name: '_HumorStore.filtered');

  @override
  bool get filtered {
    _$filteredAtom.reportRead();
    return super.filtered;
  }

  @override
  set filtered(bool value) {
    _$filteredAtom.reportWrite(value, super.filtered, () {
      super.filtered = value;
    });
  }

  final _$humorListAtom = Atom(name: '_HumorStore.humorList');

  @override
  ObservableList<RegistroHumor> get humorList {
    _$humorListAtom.reportRead();
    return super.humorList;
  }

  @override
  set humorList(ObservableList<RegistroHumor> value) {
    _$humorListAtom.reportWrite(value, super.humorList, () {
      super.humorList = value;
    });
  }

  final _$deleteHumorAsyncAction = AsyncAction('_HumorStore.deleteHumor');

  @override
  Future<void> deleteHumor(RegistroHumor humor) {
    return _$deleteHumorAsyncAction.run(() => super.deleteHumor(humor));
  }

  final _$_HumorStoreActionController = ActionController(name: '_HumorStore');

  @override
  void toggleFilter() {
    final _$actionInfo = _$_HumorStoreActionController.startAction(
        name: '_HumorStore.toggleFilter');
    try {
      return super.toggleFilter();
    } finally {
      _$_HumorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  RegistroHumor createHumor(TipoHumor tipoHumor) {
    final _$actionInfo = _$_HumorStoreActionController.startAction(
        name: '_HumorStore.createHumor');
    try {
      return super.createHumor(tipoHumor);
    } finally {
      _$_HumorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editHumor(RegistroHumor humor) {
    final _$actionInfo = _$_HumorStoreActionController.startAction(
        name: '_HumorStore.editHumor');
    try {
      return super.editHumor(humor);
    } finally {
      _$_HumorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
startDate: ${startDate},
endDate: ${endDate},
filtered: ${filtered},
humorList: ${humorList},
filteredHumors: ${filteredHumors}
    ''';
  }
}
