// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Humor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistroHumor _$RegistroHumorFromJson(Map<String, dynamic> json) {
  return RegistroHumor(
    tipo: _$enumDecodeNullable(_$TipoHumorEnumMap, json['tipo']),
    id: json['id'] as String,
    disforico: json['disforico'] as bool,
    data: json['data'] == null ? null : DateTime.parse(json['data'] as String),
    nota: json['nota'] as int,
    medicamentos: (json['medicamentos'] as List)
        ?.map((e) => e == null
            ? null
            : RegistroMedicamento.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    horasDormidas: json['horasDormidas'] as int,
    periodoMenstrual: json['periodoMenstrual'] as bool,
    eventoDeVida: json['eventoDeVida'] as String,
    impactoEvento: (json['impactoEvento'] as num)?.toDouble(),
    sintomas: json['sintomas'] as String,
    otherInfo: json['otherInfo'] as String,
  );
}

Map<String, dynamic> _$RegistroHumorToJson(RegistroHumor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tipo': _$TipoHumorEnumMap[instance.tipo],
      'disforico': instance.disforico,
      'data': instance.data?.toIso8601String(),
      'nota': instance.nota,
      'medicamentos':
          const _ObservableListJsonConverter().toJson(instance.medicamentos),
      'horasDormidas': instance.horasDormidas,
      'periodoMenstrual': instance.periodoMenstrual,
      'eventoDeVida': instance.eventoDeVida,
      'impactoEvento': instance.impactoEvento,
      'sintomas': instance.sintomas,
      'otherInfo': instance.otherInfo,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TipoHumorEnumMap = {
  TipoHumor.graveDepre: 'graveDepre',
  TipoHumor.modGraveDepre: 'modGraveDepre',
  TipoHumor.modLeveDepre: 'modLeveDepre',
  TipoHumor.leveDepre: 'leveDepre',
  TipoHumor.estavel: 'estavel',
  TipoHumor.leveMania: 'leveMania',
  TipoHumor.modLeveMania: 'modLeveMania',
  TipoHumor.modGraveMania: 'modGraveMania',
  TipoHumor.graveMania: 'graveMania',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegistroHumor on _RegistroHumor, Store {
  final _$tipoAtom = Atom(name: '_RegistroHumor.tipo');

  @override
  TipoHumor get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(TipoHumor value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  final _$disforicoAtom = Atom(name: '_RegistroHumor.disforico');

  @override
  bool get disforico {
    _$disforicoAtom.reportRead();
    return super.disforico;
  }

  @override
  set disforico(bool value) {
    _$disforicoAtom.reportWrite(value, super.disforico, () {
      super.disforico = value;
    });
  }

  final _$dataAtom = Atom(name: '_RegistroHumor.data');

  @override
  DateTime get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(DateTime value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$notaAtom = Atom(name: '_RegistroHumor.nota');

  @override
  int get nota {
    _$notaAtom.reportRead();
    return super.nota;
  }

  @override
  set nota(int value) {
    _$notaAtom.reportWrite(value, super.nota, () {
      super.nota = value;
    });
  }

  final _$medicamentosAtom = Atom(name: '_RegistroHumor.medicamentos');

  @override
  ObservableList<RegistroMedicamento> get medicamentos {
    _$medicamentosAtom.reportRead();
    return super.medicamentos;
  }

  @override
  set medicamentos(ObservableList<RegistroMedicamento> value) {
    _$medicamentosAtom.reportWrite(value, super.medicamentos, () {
      super.medicamentos = value;
    });
  }

  final _$horasDormidasAtom = Atom(name: '_RegistroHumor.horasDormidas');

  @override
  int get horasDormidas {
    _$horasDormidasAtom.reportRead();
    return super.horasDormidas;
  }

  @override
  set horasDormidas(int value) {
    _$horasDormidasAtom.reportWrite(value, super.horasDormidas, () {
      super.horasDormidas = value;
    });
  }

  final _$periodoMenstrualAtom = Atom(name: '_RegistroHumor.periodoMenstrual');

  @override
  bool get periodoMenstrual {
    _$periodoMenstrualAtom.reportRead();
    return super.periodoMenstrual;
  }

  @override
  set periodoMenstrual(bool value) {
    _$periodoMenstrualAtom.reportWrite(value, super.periodoMenstrual, () {
      super.periodoMenstrual = value;
    });
  }

  final _$eventoDeVidaAtom = Atom(name: '_RegistroHumor.eventoDeVida');

  @override
  String get eventoDeVida {
    _$eventoDeVidaAtom.reportRead();
    return super.eventoDeVida;
  }

  @override
  set eventoDeVida(String value) {
    _$eventoDeVidaAtom.reportWrite(value, super.eventoDeVida, () {
      super.eventoDeVida = value;
    });
  }

  final _$impactoEventoAtom = Atom(name: '_RegistroHumor.impactoEvento');

  @override
  double get impactoEvento {
    _$impactoEventoAtom.reportRead();
    return super.impactoEvento;
  }

  @override
  set impactoEvento(double value) {
    _$impactoEventoAtom.reportWrite(value, super.impactoEvento, () {
      super.impactoEvento = value;
    });
  }

  final _$sintomasAtom = Atom(name: '_RegistroHumor.sintomas');

  @override
  String get sintomas {
    _$sintomasAtom.reportRead();
    return super.sintomas;
  }

  @override
  set sintomas(String value) {
    _$sintomasAtom.reportWrite(value, super.sintomas, () {
      super.sintomas = value;
    });
  }

  final _$otherInfoAtom = Atom(name: '_RegistroHumor.otherInfo');

  @override
  String get otherInfo {
    _$otherInfoAtom.reportRead();
    return super.otherInfo;
  }

  @override
  set otherInfo(String value) {
    _$otherInfoAtom.reportWrite(value, super.otherInfo, () {
      super.otherInfo = value;
    });
  }

  @override
  String toString() {
    return '''
tipo: ${tipo},
disforico: ${disforico},
data: ${data},
nota: ${nota},
medicamentos: ${medicamentos},
horasDormidas: ${horasDormidas},
periodoMenstrual: ${periodoMenstrual},
eventoDeVida: ${eventoDeVida},
impactoEvento: ${impactoEvento},
sintomas: ${sintomas},
otherInfo: ${otherInfo}
    ''';
  }
}
