import 'package:mobx/mobx.dart';
import '../models/User.dart';

part 'LoginStore.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  UserProfile userProfile;

  _LoginStore();

  @computed
  bool get logged => userProfile != null;

  @action
  Future<void> login (String user, String password) async {
    await Future.delayed(Duration(seconds: 2));
    userProfile = UserProfile(nome: "John",
    sobrenome: "Dalton",
    email: user,
    nascimento: new DateTime.utc(1989, 11, 9),
    sexo: Sexo.masc,
    diagnosticos: ['TOC', 'Depressão']);
  }

  @action
  Future<void> logout () async {
    await Future.delayed(Duration(seconds: 2));
    userProfile = null;
  }
}