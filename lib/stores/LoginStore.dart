import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import '../models/User.dart';

part 'LoginStore.g.dart';

enum LoginStatus { LoggedOff, LoggedIn }
enum RegisterError { Invalid, Unavailable }

class LoginError {}

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  static final _default_user = UserProfile(
      email: "john.dalton@exemplo.com",
      password: "senha",
      nome: "John",
      sobrenome: "Dalton",
      sexo: Sexo.masc);

  List<UserProfile> _userlist = [_default_user];

  @observable
  UserProfile userProfile = _default_user;

  @observable
  LoginStatus loginStatus = LoginStatus.LoggedIn;

  @action
  Future<void> login(String user, String password) async {
    var a = _userlist.where((u) => u.email == user).toList();
    if (a.isNotEmpty && a[0].password == password) {
      userProfile = a[0];
      loginStatus = LoginStatus.LoggedIn;
    } else {
      throw LoginError();
    }
  }

  @action
  Future<void> logout() async {
    await Future.delayed(Duration(seconds: 1));
    loginStatus = LoginStatus.LoggedOff;
  }

  @action
  Future<void> register(UserProfile user, String password) async {
    await Future.delayed(Duration(seconds: 1));
    var a = _userlist.where((u) => u.email == user.email).toList();
    if (a.isEmpty) {
      user.password = password;
      _userlist.add(user);
      userProfile = user;
      loginStatus = LoginStatus.LoggedIn;
    } else {
      throw RegisterError.Unavailable;
    }
  }
}
