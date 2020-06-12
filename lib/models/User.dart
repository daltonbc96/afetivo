import 'package:afetivo/models/Medicamento.dart';
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
  UserProfile({
    String nome,
    String sobrenome,
    String email,
    DateTime nascimento,
    Sexo sexo,
    List<String> diagnosticos,
    List<Medicamento> medicamentos,
  }) : super(
          nome: nome,
          sobrenome: sobrenome,
          email: email,
          nascimento: nascimento,
          sexo: sexo,
          diagnosticos: ObservableList.of(diagnosticos ?? []),
          medicamentos: ObservableList.of(medicamentos ?? []),
        );

  UserProfile.from(UserProfile src)
      : super(
          nome: src.nome,
          sobrenome: src.sobrenome,
          email: src.email,
          nascimento: src.nascimento,
          sexo: src.sexo,
          diagnosticos: ObservableList.of(src.diagnosticos ?? []),
          medicamentos: ObservableList.of(src.medicamentos ?? []),
        );

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
  DateTime nascimento;

  @observable
  Sexo sexo;

  @computed
  String get descSexo => describeSexo(sexo);

  @computed
  String get fullName => nome + " " + sobrenome;

  @observable
  ObservableList<String> diagnosticos = ObservableList<String>();

  @observable
  @_ObservableListJsonConverter()
  ObservableList<Medicamento> medicamentos = ObservableList<Medicamento>();

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

  @action
  void deleteMedicamento(Medicamento medicamento) {
    medicamentos.remove(medicamento);
  }

  @action
  void addMedicamento(Medicamento medicamento) {
    print(medicamento);
    if (!medicamentos.contains(medicamento)) {
      medicamentos.add(medicamento);
    }
  }

  _UserProfile(
      {this.nome,
      this.sobrenome,
      this.email,
      this.nascimento,
      this.sexo,
      this.diagnosticos,
      this.medicamentos});
}

class _ObservableListJsonConverter
    implements
        JsonConverter<ObservableList<Medicamento>, List<Map<String, dynamic>>> {
  const _ObservableListJsonConverter();

  @override
  ObservableList<Medicamento> fromJson(List<Map<String, dynamic>> json) =>
      ObservableList.of(json.map((x) => Medicamento.fromJson(x)));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<Medicamento> list) =>
      list.map((x) => x.toJson()).toList();
}
