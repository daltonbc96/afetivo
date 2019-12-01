import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'User.g.dart';

enum Sexo { masc, fem, other }

String describeSexo(Sexo sexo) {
  switch (sexo) {
    case Sexo.fem:
      return 'Feminino';
    case Sexo.masc:
      return 'Masculino';
    case Sexo.other:
      return 'Outro';
  }

  return "";
}

@JsonSerializable()
class UserProfile extends _UserProfile with _$UserProfile {
  UserProfile(
      {String nome,
      String sobrenome,
      String email,
      String password,
      DateTime nascimento,
      Sexo sexo,
      List<String> diagnosticos})
      : super(
            nome: nome,
            sobrenome: sobrenome,
            email: email,
            password: password,
            nascimento: nascimento,
            sexo: sexo,
            diagnosticos: ObservableList.of(diagnosticos ?? []));

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

abstract class _UserProfile with Store {
  @observable
  String nome;

  @observable
  String sobrenome;

  @observable
  String email;

  @observable
  String password;

  @observable
  DateTime nascimento;

  @observable
  Sexo sexo;

  @computed
  String get descSexo => describeSexo(sexo);

  @computed
  String get fullName => nome + " " + sobrenome;

  @observable
  ObservableList<String> diagnosticos = ObservableList<String>();

  @action
  void deleteDiagnostico(String diagnostico) {
    diagnostico = diagnostico.trim();
    diagnosticos.remove(diagnostico);
  }

  @action
  void addDiagnostico(String diagnostico) {
    diagnostico = diagnostico.trim();
    if (!diagnosticos.contains(diagnostico)) {
      diagnosticos.add(diagnostico);
    }
  }

  _UserProfile(
      {this.nome,
      this.sobrenome,
      this.email,
      this.password,
      this.nascimento,
      this.sexo,
      this.diagnosticos});
}
