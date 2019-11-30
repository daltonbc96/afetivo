// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool> _$loggedComputed;

  @override
  bool get logged =>
      (_$loggedComputed ??= Computed<bool>(() => super.logged)).value;

  final _$userProfileAtom = Atom(name: '_LoginStore.userProfile');

  @override
  UserProfile get userProfile {
    _$userProfileAtom.context.enforceReadPolicy(_$userProfileAtom);
    _$userProfileAtom.reportObserved();
    return super.userProfile;
  }

  @override
  set userProfile(UserProfile value) {
    _$userProfileAtom.context.conditionallyRunInAction(() {
      super.userProfile = value;
      _$userProfileAtom.reportChanged();
    }, _$userProfileAtom, name: '${_$userProfileAtom.name}_set');
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<void> login(String user, String password) {
    return _$loginAsyncAction.run(() => super.login(user, password));
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$registerAsyncAction = AsyncAction('register');

  @override
  Future<void> register(UserProfile user, String password) {
    return _$registerAsyncAction.run(() => super.register(user, password));
  }
}
