// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Humor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistroHumor _$RegistroHumorFromJson(Map<String, dynamic> json) {
  return RegistroHumor(
    tipo: _$enumDecodeNullable(_$TipoHumorEnumMap, json['tipo']),
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
    _$tipoAtom.context.enforceReadPolicy(_$tipoAtom);
    _$tipoAtom.reportObserved();
    return super.tipo;
  }

  @override
  set tipo(TipoHumor value) {
    _$tipoAtom.context.conditionallyRunInAction(() {
      super.tipo = value;
      _$tipoAtom.reportChanged();
    }, _$tipoAtom, name: '${_$tipoAtom.name}_set');
  }

  final _$disforicoAtom = Atom(name: '_RegistroHumor.disforico');

  @override
  bool get disforico {
    _$disforicoAtom.context.enforceReadPolicy(_$disforicoAtom);
    _$disforicoAtom.reportObserved();
    return super.disforico;
  }

  @override
  set disforico(bool value) {
    _$disforicoAtom.context.conditionallyRunInAction(() {
      super.disforico = value;
      _$disforicoAtom.reportChanged();
    }, _$disforicoAtom, name: '${_$disforicoAtom.name}_set');
  }

  final _$dataAtom = Atom(name: '_RegistroHumor.data');

  @override
  DateTime get data {
    _$dataAtom.context.enforceReadPolicy(_$dataAtom);
    _$dataAtom.reportObserved();
    return super.data;
  }

  @override
  set data(DateTime value) {
    _$dataAtom.context.conditionallyRunInAction(() {
      super.data = value;
      _$dataAtom.reportChanged();
    }, _$dataAtom, name: '${_$dataAtom.name}_set');
  }

  final _$notaAtom = Atom(name: '_RegistroHumor.nota');

  @override
  int get nota {
    _$notaAtom.context.enforceReadPolicy(_$notaAtom);
    _$notaAtom.reportObserved();
    return super.nota;
  }

  @override
  set nota(int value) {
    _$notaAtom.context.conditionallyRunInAction(() {
      super.nota = value;
      _$notaAtom.reportChanged();
    }, _$notaAtom, name: '${_$notaAtom.name}_set');
  }

  final _$medicamentosAtom = Atom(name: '_RegistroHumor.medicamentos');

  @override
  ObservableList<RegistroMedicamento> get medicamentos {
    _$medicamentosAtom.context.enforceReadPolicy(_$medicamentosAtom);
    _$medicamentosAtom.reportObserved();
    return super.medicamentos;
  }

  @override
  set medicamentos(ObservableList<RegistroMedicamento> value) {
    _$medicamentosAtom.context.conditionallyRunInAction(() {
      super.medicamentos = value;
      _$medicamentosAtom.reportChanged();
    }, _$medicamentosAtom, name: '${_$medicamentosAtom.name}_set');
  }

  final _$horasDormidasAtom = Atom(name: '_RegistroHumor.horasDormidas');

  @override
  int get horasDormidas {
    _$horasDormidasAtom.context.enforceReadPolicy(_$horasDormidasAtom);
    _$horasDormidasAtom.reportObserved();
    return super.horasDormidas;
  }

  @override
  set horasDormidas(int value) {
    _$horasDormidasAtom.context.conditionallyRunInAction(() {
      super.horasDormidas = value;
      _$horasDormidasAtom.reportChanged();
    }, _$horasDormidasAtom, name: '${_$horasDormidasAtom.name}_set');
  }

  final _$periodoMenstrualAtom = Atom(name: '_RegistroHumor.periodoMenstrual');

  @override
  bool get periodoMenstrual {
    _$periodoMenstrualAtom.context.enforceReadPolicy(_$periodoMenstrualAtom);
    _$periodoMenstrualAtom.reportObserved();
    return super.periodoMenstrual;
  }

  @override
  set periodoMenstrual(bool value) {
    _$periodoMenstrualAtom.context.conditionallyRunInAction(() {
      super.periodoMenstrual = value;
      _$periodoMenstrualAtom.reportChanged();
    }, _$periodoMenstrualAtom, name: '${_$periodoMenstrualAtom.name}_set');
  }

  final _$eventoDeVidaAtom = Atom(name: '_RegistroHumor.eventoDeVida');

  @override
  String get eventoDeVida {
    _$eventoDeVidaAtom.context.enforceReadPolicy(_$eventoDeVidaAtom);
    _$eventoDeVidaAtom.reportObserved();
    return super.eventoDeVida;
  }

  @override
  set eventoDeVida(String value) {
    _$eventoDeVidaAtom.context.conditionallyRunInAction(() {
      super.eventoDeVida = value;
      _$eventoDeVidaAtom.reportChanged();
    }, _$eventoDeVidaAtom, name: '${_$eventoDeVidaAtom.name}_set');
  }

  final _$impactoEventoAtom = Atom(name: '_RegistroHumor.impactoEvento');

  @override
  double get impactoEvento {
    _$impactoEventoAtom.context.enforceReadPolicy(_$impactoEventoAtom);
    _$impactoEventoAtom.reportObserved();
    return super.impactoEvento;
  }

  @override
  set impactoEvento(double value) {
    _$impactoEventoAtom.context.conditionallyRunInAction(() {
      super.impactoEvento = value;
      _$impactoEventoAtom.reportChanged();
    }, _$impactoEventoAtom, name: '${_$impactoEventoAtom.name}_set');
  }

  final _$sintomasAtom = Atom(name: '_RegistroHumor.sintomas');

  @override
  String get sintomas {
    _$sintomasAtom.context.enforceReadPolicy(_$sintomasAtom);
    _$sintomasAtom.reportObserved();
    return super.sintomas;
  }

  @override
  set sintomas(String value) {
    _$sintomasAtom.context.conditionallyRunInAction(() {
      super.sintomas = value;
      _$sintomasAtom.reportChanged();
    }, _$sintomasAtom, name: '${_$sintomasAtom.name}_set');
  }

  final _$otherInfoAtom = Atom(name: '_RegistroHumor.otherInfo');

  @override
  String get otherInfo {
    _$otherInfoAtom.context.enforceReadPolicy(_$otherInfoAtom);
    _$otherInfoAtom.reportObserved();
    return super.otherInfo;
  }

  @override
  set otherInfo(String value) {
    _$otherInfoAtom.context.conditionallyRunInAction(() {
      super.otherInfo = value;
      _$otherInfoAtom.reportChanged();
    }, _$otherInfoAtom, name: '${_$otherInfoAtom.name}_set');
  }
}
