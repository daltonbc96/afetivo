import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import '../models/User.dart';

part 'LoginStore.g.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _fireStore = Firestore.instance;
enum RegisterError { Invalid, Unavailable, WeakPassword, UnknownError }

class LoginError {}

class LoginStore extends _LoginStore with _$LoginStore {
  LoginStore() {
    _firebaseAuth.onAuthStateChanged.listen((user) {
      if (user != null) {
        this.uid = user.uid;
        _fireStore.collection("users").document(user.uid).get().then((value) {
          this.userProfile = UserProfile.fromJson(value.data);
        });
      } else {
        this.uid = null;
        this.userProfile = null;
      }
    });
  }
}

abstract class _LoginStore with Store {
  @observable
  UserProfile userProfile;

  @observable
  String uid;

  @computed
  Future<bool> get isLoggedIn async =>
      (await _firebaseAuth.currentUser()) != null;

  @action
  Future<void> login(String email, String password) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      if (response.user == null) throw LoginError();
    } on AuthException catch (e) {
      switch (e.code) {
        default:
          throw LoginError();
      }
    }
  }

  @action
  Future<void> logout() => _firebaseAuth.signOut();

  @action
  Future<void> register(UserProfile user, String password) async {
    // TODO: Validate register
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email.trim(), password: password);
      await _fireStore
          .collection('users')
          .document(result.user.uid)
          .setData(user.toJson());
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
}
