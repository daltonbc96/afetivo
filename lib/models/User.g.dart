// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    nome: json['nome'] as String,
    sobrenome: json['sobrenome'] as String,
    email: json['email'] as String,
    nascimento: json['nascimento'] == null
        ? null
        : DateTime.parse(json['nascimento'] as String),
    sexo: _$enumDecodeNullable(_$SexoEnumMap, json['sexo']),
    diagnosticos:
        (json['diagnosticos'] as List)?.map((e) => e as String)?.toList(),
    medicamentos: (json['medicamentos'] as List)
        ?.map((e) =>
            e == null ? null : Medicamento.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'sobrenome': instance.sobrenome,
      'email': instance.email,
      'nascimento': instance.nascimento?.toIso8601String(),
      'sexo': _$SexoEnumMap[instance.sexo],
      'diagnosticos': instance.diagnosticos,
      'medicamentos':
          const _ObservableListJsonConverter().toJson(instance.medicamentos),
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

const _$SexoEnumMap = {
  Sexo.masc: 'masc',
  Sexo.fem: 'fem',
  Sexo.other: 'other',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserProfile on _UserProfile, Store {
  Computed<String> _$descSexoComputed;

  @override
  String get descSexo => (_$descSexoComputed ??=
          Computed<String>(() => super.descSexo, name: '_UserProfile.descSexo'))
      .value;
  Computed<String> _$fullNameComputed;

  @override
  String get fullName => (_$fullNameComputed ??=
          Computed<String>(() => super.fullName, name: '_UserProfile.fullName'))
      .value;

  final _$nomeAtom = Atom(name: '_UserProfile.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$sobrenomeAtom = Atom(name: '_UserProfile.sobrenome');

  @override
  String get sobrenome {
    _$sobrenomeAtom.reportRead();
    return super.sobrenome;
  }

  @override
  set sobrenome(String value) {
    _$sobrenomeAtom.reportWrite(value, super.sobrenome, () {
      super.sobrenome = value;
    });
  }

  final _$emailAtom = Atom(name: '_UserProfile.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$nascimentoAtom = Atom(name: '_UserProfile.nascimento');

  @override
  DateTime get nascimento {
    _$nascimentoAtom.reportRead();
    return super.nascimento;
  }

  @override
  set nascimento(DateTime value) {
    _$nascimentoAtom.reportWrite(value, super.nascimento, () {
      super.nascimento = value;
    });
  }

  final _$sexoAtom = Atom(name: '_UserProfile.sexo');

  @override
  Sexo get sexo {
    _$sexoAtom.reportRead();
    return super.sexo;
  }

  @override
  set sexo(Sexo value) {
    _$sexoAtom.reportWrite(value, super.sexo, () {
      super.sexo = value;
    });
  }

  final _$diagnosticosAtom = Atom(name: '_UserProfile.diagnosticos');

  @override
  ObservableList<String> get diagnosticos {
    _$diagnosticosAtom.reportRead();
    return super.diagnosticos;
  }

  @override
  set diagnosticos(ObservableList<String> value) {
    _$diagnosticosAtom.reportWrite(value, super.diagnosticos, () {
      super.diagnosticos = value;
    });
  }

  final _$medicamentosAtom = Atom(name: '_UserProfile.medicamentos');

  @override
  ObservableList<Medicamento> get medicamentos {
    _$medicamentosAtom.reportRead();
    return super.medicamentos;
  }

  @override
  set medicamentos(ObservableList<Medicamento> value) {
    _$medicamentosAtom.reportWrite(value, super.medicamentos, () {
      super.medicamentos = value;
    });
  }

  final _$_UserProfileActionController = ActionController(name: '_UserProfile');

  @override
  void deleteDiagnostico(String diagnostico) {
    final _$actionInfo = _$_UserProfileActionController.startAction(
        name: '_UserProfile.deleteDiagnostico');
    try {
      return super.deleteDiagnostico(diagnostico);
    } finally {
      _$_UserProfileActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addDiagnostico(String diagnostico) {
    final _$actionInfo = _$_UserProfileActionController.startAction(
        name: '_UserProfile.addDiagnostico');
    try {
      return super.addDiagnostico(diagnostico);
    } finally {
      _$_UserProfileActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteMedicamento(Medicamento medicamento) {
    final _$actionInfo = _$_UserProfileActionController.startAction(
        name: '_UserProfile.deleteMedicamento');
    try {
      return super.deleteMedicamento(medicamento);
    } finally {
      _$_UserProfileActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMedicamento(Medicamento medicamento) {
    final _$actionInfo = _$_UserProfileActionController.startAction(
        name: '_UserProfile.addMedicamento');
    try {
      return super.addMedicamento(medicamento);
    } finally {
      _$_UserProfileActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
sobrenome: ${sobrenome},
email: ${email},
nascimento: ${nascimento},
sexo: ${sexo},
diagnosticos: ${diagnosticos},
medicamentos: ${medicamentos},
descSexo: ${descSexo},
fullName: ${fullName}
    ''';
  }
}
