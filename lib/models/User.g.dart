// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
      nome: json['nome'] as String,
      sobrenome: json['sobrenome'] as String,
      nascimento: json['nascimento'] == null
          ? null
          : DateTime.parse(json['nascimento'] as String),
      sexo: _$enumDecodeNullable(_$SexoEnumMap, json['sexo']),
      diagnosticos:
          (json['diagnosticos'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'sobrenome': instance.sobrenome,
      'nascimento': instance.nascimento?.toIso8601String(),
      'sexo': _$SexoEnumMap[instance.sexo],
      'diagnosticos': instance.diagnosticos
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

const _$SexoEnumMap = <Sexo, dynamic>{
  Sexo.masc: 'masc',
  Sexo.fem: 'fem',
  Sexo.other: 'other'
};
