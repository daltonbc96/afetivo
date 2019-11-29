import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'Medicamento.g.dart';

@JsonSerializable()
class Medicamento extends _Medicamento with _$Medicamento {
  Medicamento({String nome, double dose}) : super(nome: nome, dose: dose);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Medicamento.fromJson(Map<String, dynamic> json) =>
      _$MedicamentoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MedicamentoToJson(this);
}

abstract class _Medicamento with Store {
  @observable
  String nome;

  @observable
  double dose;

  _Medicamento({this.nome, this.dose});
}

@JsonSerializable(explicitToJson: true)
class RegistroMedicamento extends _RegistroMedicamento
    with _$RegistroMedicamento {
  RegistroMedicamento({Medicamento medicamento, int numeroComprimidos})
      : super(medicamento: medicamento, numeroComprimidos: numeroComprimidos);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RegistroMedicamento.fromJson(Map<String, dynamic> json) =>
      _$RegistroMedicamentoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RegistroMedicamentoToJson(this);
}

abstract class _RegistroMedicamento with Store {
  @observable
  Medicamento medicamento;
  @observable
  int numeroComprimidos;

  _RegistroMedicamento({this.medicamento, this.numeroComprimidos});
}
