// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Humor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistroHumor _$RegistroHumorFromJson(Map<String, dynamic> json) {
  return RegistroHumor(
      tipo: _$enumDecodeNullable(_$TipoHumorEnumMap, json['tipo']),
      disforico: json['disforico'] as bool,
      data:
          json['data'] == null ? null : DateTime.parse(json['data'] as String),
      nota: json['nota'] as int,
      medicamentos: (json['medicamentos'] as List)
          ?.map((e) => e == null
              ? null
              : RegistroMedicamento.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      horasDormidas: (json['horasDormidas'] as num)?.toDouble(),
      periodoMenstrual: json['periodoMenstrual'] as bool,
      eventoDeVida: json['eventoDeVida'] as String,
      impactoEvento: json['impactoEvento'] as int,
      sintomas: json['sintomas'] as String,
      otherInfo: json['otherInfo'] as String);
}

Map<String, dynamic> _$RegistroHumorToJson(RegistroHumor instance) =>
    <String, dynamic>{
      'tipo': _$TipoHumorEnumMap[instance.tipo],
      'disforico': instance.disforico,
      'data': instance.data?.toIso8601String(),
      'nota': instance.nota,
      'medicamentos': instance.medicamentos,
      'horasDormidas': instance.horasDormidas,
      'periodoMenstrual': instance.periodoMenstrual,
      'eventoDeVida': instance.eventoDeVida,
      'impactoEvento': instance.impactoEvento,
      'sintomas': instance.sintomas,
      'otherInfo': instance.otherInfo
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$TipoHumorEnumMap = <TipoHumor, dynamic>{
  TipoHumor.graveDepre: 'graveDepre',
  TipoHumor.modGraveDepre: 'modGraveDepre',
  TipoHumor.modLeveDepre: 'modLeveDepre',
  TipoHumor.leveDepre: 'leveDepre',
  TipoHumor.estavel: 'estavel',
  TipoHumor.leveMania: 'leveMania',
  TipoHumor.modLeveMania: 'modLeveMania',
  TipoHumor.modGraveMania: 'modGraveMania',
  TipoHumor.graveMania: 'graveMania'
};
