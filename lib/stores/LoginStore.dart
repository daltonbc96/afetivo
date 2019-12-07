import 'package:mobx/mobx.dart';
import '../models/User.dart';

part 'LoginStore.g.dart';

enum LoginStatus { LoggedOff, LoginWait, LoggedIn, LoginError }

class LoginStore extends _LoginStore with _$LoginStore {
  static final instance = LoginStore();
}

abstract class _LoginStore with Store {
  List<UserProfile> _userlist = [
    UserProfile(
        email: "john.dalton@exemplo.com",
        password: "senha",
        nome: "John",
        sobrenome: "Dalton",
        sexo: Sexo.masc)
  ];

  @observable
  UserProfile userProfile;

  @observable
  LoginStatus loginStatus;

  @action
  Future<void> login(String user, String password) async {
    loginStatus = LoginStatus.LoginWait;
    await Future.delayed(Duration(seconds: 1));
    var a = _userlist.where((u) => u.email == user).toList();
    if (a.isNotEmpty && a[0].password == password) {
      userProfile = a[0];
      loginStatus = LoginStatus.LoggedIn;
    } else {
      loginStatus = LoginStatus.LoginError;
    }
  }

  @action
  Future<void> logout() async {
    loginStatus = LoginStatus.LoginWait;
    await Future.delayed(Duration(seconds: 1));
    loginStatus = LoginStatus.LoggedOff;
  }

  @action
  Future<void> register(UserProfile user, String password) async {
    loginStatus = LoginStatus.LoginWait;
    await Future.delayed(Duration(seconds: 1));
    var a = _userlist.where((u) => u.email == user.email).toList();
    if (a.isEmpty) {
      print("Registering user");
      user.password = password;
      _userlist.add(user);
      userProfile = user;
      loginStatus = LoginStatus.LoggedIn;
    }
  }
}
