import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import '../models/User.dart';

part 'LoginStore.g.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _fireStore = Firestore.instance;
enum RegisterError {
  NotAnError,
  Invalid,
  Unavailable,
  WeakPassword,
  UnknownError
}
enum LoginState { Loading, LoggedOut, NoProfile, LoggedIn }

class LoginError {}

class LoginStore extends _LoginStore with _$LoginStore {
  StreamSubscription _snapshotsSubscription;

  LoginStore() {
    _firebaseAuth.onAuthStateChanged.listen((user) async {
      if (user != null) {
        this.uid = user.uid;
        if (_snapshotsSubscription != null) {
          await _snapshotsSubscription.cancel();
          _snapshotsSubscription = null;
        }
        final document = _fireStore.collection("users").document(user.uid);

        if (await document.get() == null) loginState = LoginState.NoProfile;

        _snapshotsSubscription = document.snapshots().listen((value) {
          if (value.data == null)
            this.loginState = LoginState.NoProfile;
          else {
            this.userProfile = UserProfile.fromJson(value.data);
            this.email = user.email;
            this.userProfile.email = user.email;
            this.loginState = LoginState.LoggedIn;
          }
        });
      } else {
        this.uid = null;
        this.userProfile = null;
        this.email = null;
        this.loginState = LoginState.LoggedOut;
      }
    });
  }
}

abstract class _LoginStore with Store {
  @observable
  UserProfile userProfile;

  @observable
  String uid;

  @observable
  String email;

  @computed
  bool get isLoggedIn => uid != null;

  @computed
  bool get hasUserProfile => userProfile != null;

  @observable
  LoginState loginState = LoginState.Loading;

  @action
  Future<void> login(String email, String password) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      if (response.user == null) throw LoginError();
    } catch (_) {
      throw LoginError();
    }
  }

  @action
  Future<void> logout() => _firebaseAuth.signOut();

  @action
  Future<void> createUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on AuthException catch (e) {
      switch (e.code) {
        case 'FirebaseAuthUserCollisionException':
          throw RegisterError.Unavailable;
          break;
        case 'FirebaseAuthWeakPasswordException':
          throw RegisterError.WeakPassword;
          break;
        default:
          throw RegisterError.UnknownError;
          break;
      }
    } catch (_) {
      throw RegisterError.UnknownError;
    }
  }

  @action
  void register(UserProfile user) {
    user.email = email;
    _fireStore.collection('users').document(uid).setData(user.toJson());
  }
}
