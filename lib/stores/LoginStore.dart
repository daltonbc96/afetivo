import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import '../models/User.dart';

part 'LoginStore.g.dart';

enum RegisterError {
  NotAnError,
  Invalid,
  Unavailable,
  WeakPassword,
  UnknownError
}
enum LoginState { Loading, LoggedOut, NoProfile, LoggedIn }
enum LoginMethod { EmailAndPassword, GoogleSignIn }

class LoginError {}

class LoginStore extends _LoginStore with _$LoginStore {
  StreamSubscription _snapshotsSubscription;
  static LoginStore _instance;

  factory LoginStore() {
    if (_instance == null) _instance = LoginStore._();

    return _instance;
  }

  LoginStore._() {
    _firebaseAuth.authStateChanges().listen((user) async {
      if (user != null) {
        if (_snapshotsSubscription != null) {
          await _snapshotsSubscription.cancel();
          _snapshotsSubscription = null;
        }
        this.uid = user.uid;

        final document = _fireStore.collection("users").doc(user.uid);
        if (await document.get() == null) {
          loginState = LoginState.NoProfile;
          this.userProfile = UserProfile(email: user.email);
        }

        _snapshotsSubscription = document.snapshots().listen((value) {
          if (value.data == null) {
            this.loginState = LoginState.NoProfile;
            this.userProfile = UserProfile(email: user.email);
          } else {
            this.userProfile = UserProfile.fromJson(value.data());
            this.loginState = LoginState.LoggedIn;
          }
        });
      } else {
        this.uid = null;
        this.userProfile = null;
        this.loginState = LoginState.LoggedOut;
      }
    });
  }
}

abstract class _LoginStore with Store {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  @observable
  UserProfile userProfile;

  @observable
  String uid;

  @observable
  LoginMethod loginMethod;

  @computed
  bool get isLoggedIn => uid != null;

  @computed
  bool get hasUserProfile => loginState == LoginState.LoggedIn;

  @observable
  LoginState loginState = LoginState.Loading;

  @action
  Future<void> login(String email, String password) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      if (response.user == null) throw LoginError();
      loginMethod = LoginMethod.EmailAndPassword;
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
          email: email.trim(), password: password);
      loginMethod = LoginMethod.EmailAndPassword;
    } on FirebaseAuthException catch (e) {
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
    _fireStore.collection('users').doc(uid).set(user.toJson());
  }
}
