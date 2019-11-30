import 'package:mobx/mobx.dart';
import '../models/User.dart';

part 'LoginStore.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  List<UserProfile> _userlist = List();

  @observable
  UserProfile userProfile;

  @computed
  bool get logged => userProfile != null;

  @action
  Future<void> login(String user, String password) async {
    await Future.delayed(Duration(seconds: 1));
    var a = _userlist.where((u) => u.email == user).toList();
    if (a.isNotEmpty && a[0].password == password) userProfile = a[0];
  }

  @action
  Future<void> logout() async {
    await Future.delayed(Duration(seconds: 1));
    userProfile = null;
  }

  @action
  Future<void> register(UserProfile user, String password) async {
    await Future.delayed(Duration(seconds: 1));
    var a = _userlist.where((u) => u.email == user.email).toList();
    if (a.isEmpty) {
      print("Registering user");
      user.password = password;
      _userlist.add(user);
      userProfile = user;
    }
  }
}
