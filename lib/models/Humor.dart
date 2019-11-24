import 'package:json_annotation/json_annotation.dart';
import 'package:afetivo/models/Medicamento.dart';

part 'Humor.g.dart';

enum TipoHumor {
  graveDepre,
  modGraveDepre,
  modLeveDepre,
  leveDepre,
  estavel,
  leveMania,
  modLeveMania,
  modGraveMania,
  graveMania
}

@JsonSerializable()
class RegistroHumor {
  TipoHumor tipo;
  bool disforico;
  DateTime data;
  int nota;
  List<RegistroMedicamento> medicamentos;
  double horasDormidas;
  bool periodoMenstrual;
  String eventoDeVida;
  int impactoEvento;
  String sintomas;
  String otherInfo;

  RegistroHumor({this.tipo, this.disforico, this.data, this.nota,
      this.medicamentos, this.horasDormidas, this.periodoMenstrual,
      this.eventoDeVida, this.impactoEvento, this.sintomas, this.otherInfo});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RegistroHumor.fromJson(Map<String, dynamic> json) =>
      _$RegistroHumorFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RegistroHumorToJson(this);
}