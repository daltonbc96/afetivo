import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:afetivo/models/Medicamento.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

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

bool tipoHumorManiaco(TipoHumor tipoHumor) {
  switch (tipoHumor) {
    case TipoHumor.leveMania:
    case TipoHumor.modLeveMania:
    case TipoHumor.modGraveMania:
    case TipoHumor.graveMania:
      return true;
    default:
  }
  return false;
}

String describeTipoHumor(TipoHumor humor) {
  switch (humor) {
    case TipoHumor.graveDepre:
      return "Depressão Severa";
    case TipoHumor.modGraveDepre:
      return "Depressão Moderada Alta";
    case TipoHumor.modLeveDepre:
      return "Depressão Moderada Baixa";
    case TipoHumor.leveDepre:
      return "Depressão Leve";
    case TipoHumor.estavel:
      return "Estável";
    case TipoHumor.leveMania:
      return "Mania Leve";
    case TipoHumor.modLeveMania:
      return "Mania Moderada Baixa";
    case TipoHumor.modGraveMania:
      return "Mania Moderada Alta";
    case TipoHumor.graveMania:
      return "Mania Severa";
    default:
  }
  return '';
}

@JsonSerializable()
class RegistroHumor extends _RegistroHumor with _$RegistroHumor {
  RegistroHumor(
      {@required TipoHumor tipo,
      String id,
      bool disforico = false,
      DateTime data,
      int nota,
      List<RegistroMedicamento> medicamentos,
      int horasDormidas,
      bool periodoMenstrual = false,
      String eventoDeVida,
      double impactoEvento = 0,
      String sintomas,
      String otherInfo})
      : super(
            id: id ?? Uuid().v4(),
            tipo: tipo,
            disforico: disforico,
            data: data,
            nota: nota,
            medicamentos: ObservableList.of(medicamentos ?? []),
            horasDormidas: horasDormidas,
            periodoMenstrual: periodoMenstrual,
            eventoDeVida: eventoDeVida,
            impactoEvento: impactoEvento,
            sintomas: sintomas,
            otherInfo: otherInfo);

  RegistroHumor.from(RegistroHumor other)
      : super(
            id: other.id,
            tipo: other.tipo,
            disforico: other.disforico,
            data: other.data,
            nota: other.nota,
            medicamentos: other.medicamentos,
            horasDormidas: other.horasDormidas,
            periodoMenstrual: other.periodoMenstrual,
            eventoDeVida: other.eventoDeVida,
            impactoEvento: other.impactoEvento,
            sintomas: other.sintomas,
            otherInfo: other.otherInfo);

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

abstract class _RegistroHumor with Store {
  final String id;
  @observable
  TipoHumor tipo;
  @observable
  bool disforico;
  @observable
  DateTime data;
  @observable
  int nota;
  @observable
  @_ObservableListJsonConverter()
  ObservableList<RegistroMedicamento> medicamentos =
      ObservableList<RegistroMedicamento>();
  @observable
  int horasDormidas;
  @observable
  bool periodoMenstrual;
  @observable
  String eventoDeVida;
  @observable
  double impactoEvento;
  @observable
  String sintomas;
  @observable
  String otherInfo;

  _RegistroHumor(
      {@required this.id,
      this.tipo,
      this.disforico,
      this.data,
      this.nota,
      this.medicamentos,
      this.horasDormidas,
      this.periodoMenstrual,
      this.eventoDeVida,
      this.impactoEvento,
      this.sintomas,
      this.otherInfo}) {
    if (data == null) data = DateTime.now();
  }
}

class _ObservableListJsonConverter
    implements
        JsonConverter<ObservableList<RegistroMedicamento>,
            List<Map<String, dynamic>>> {
  const _ObservableListJsonConverter();

  @override
  ObservableList<RegistroMedicamento> fromJson(
          List<Map<String, dynamic>> json) =>
      ObservableList.of(json.map((x) => RegistroMedicamento.fromJson(x)));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<RegistroMedicamento> list) =>
      list.map((x) => x.toJson()).toList();
}
