// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool> _$isLoggedInComputed;

  @override
  bool get isLoggedIn =>
      (_$isLoggedInComputed ??= Computed<bool>(() => super.isLoggedIn,
              name: '_LoginStore.isLoggedIn'))
          .value;
  Computed<bool> _$hasUserProfileComputed;

  @override
  bool get hasUserProfile =>
      (_$hasUserProfileComputed ??= Computed<bool>(() => super.hasUserProfile,
              name: '_LoginStore.hasUserProfile'))
          .value;

  final _$userProfileAtom = Atom(name: '_LoginStore.userProfile');

  @override
  UserProfile get userProfile {
    _$userProfileAtom.reportRead();
    return super.userProfile;
  }

  @override
  set userProfile(UserProfile value) {
    _$userProfileAtom.reportWrite(value, super.userProfile, () {
      super.userProfile = value;
    });
  }

  final _$uidAtom = Atom(name: '_LoginStore.uid');

  @override
  String get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  final _$loginMethodAtom = Atom(name: '_LoginStore.loginMethod');

  @override
  LoginMethod get loginMethod {
    _$loginMethodAtom.reportRead();
    return super.loginMethod;
  }

  @override
  set loginMethod(LoginMethod value) {
    _$loginMethodAtom.reportWrite(value, super.loginMethod, () {
      super.loginMethod = value;
    });
  }

  final _$loginStateAtom = Atom(name: '_LoginStore.loginState');

  @override
  LoginState get loginState {
    _$loginStateAtom.reportRead();
    return super.loginState;
  }

  @override
  set loginState(LoginState value) {
    _$loginStateAtom.reportWrite(value, super.loginState, () {
      super.loginState = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_LoginStore.login');

  @override
  Future<void> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$createUserAsyncAction = AsyncAction('_LoginStore.createUser');

  @override
  Future<void> createUser(String email, String password) {
    return _$createUserAsyncAction.run(() => super.createUser(email, password));
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  Future<void> logout() {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.logout');
    try {
      return super.logout();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void register(UserProfile user) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.register');
    try {
      return super.register(user);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userProfile: ${userProfile},
uid: ${uid},
loginMethod: ${loginMethod},
loginState: ${loginState},
isLoggedIn: ${isLoggedIn},
hasUserProfile: ${hasUserProfile}
    ''';
  }
}
