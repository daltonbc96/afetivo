// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Medicamento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicamento _$MedicamentoFromJson(Map<String, dynamic> json) {
  return Medicamento(
      nome: json['nome'] as String, dose: (json['dose'] as num)?.toDouble());
}

Map<String, dynamic> _$MedicamentoToJson(Medicamento instance) =>
    <String, dynamic>{'nome': instance.nome, 'dose': instance.dose};

RegistroMedicamento _$RegistroMedicamentoFromJson(Map<String, dynamic> json) {
  return RegistroMedicamento(
      medicamento: json['medicamento'] == null
          ? null
          : Medicamento.fromJson(json['medicamento'] as Map<String, dynamic>),
      numeroComprimidos: json['numeroComprimidos'] as int);
}

Map<String, dynamic> _$RegistroMedicamentoToJson(
        RegistroMedicamento instance) =>
    <String, dynamic>{
      'medicamento': instance.medicamento,
      'numeroComprimidos': instance.numeroComprimidos
    };
