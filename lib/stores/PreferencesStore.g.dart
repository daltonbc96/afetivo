// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PreferencesStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PreferencesStore on _PreferencesStore, Store {
  final _$firstRunAtom = Atom(name: '_PreferencesStore.firstRun');

  @override
  bool get firstRun {
    _$firstRunAtom.reportRead();
    return super.firstRun;
  }

  @override
  set firstRun(bool value) {
    _$firstRunAtom.reportWrite(value, super.firstRun, () {
      super.firstRun = value;
    });
  }

  final _$setFirstRunAsyncAction = AsyncAction('_PreferencesStore.setFirstRun');

  @override
  Future<void> setFirstRun(bool value) {
    return _$setFirstRunAsyncAction.run(() => super.setFirstRun(value));
  }

  @override
  String toString() {
    return '''
firstRun: ${firstRun}
    ''';
  }
}
