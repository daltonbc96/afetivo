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
    password: json['password'] as String,
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
      'password': instance.password,
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
  String get descSexo =>
      (_$descSexoComputed ??= Computed<String>(() => super.descSexo)).value;
  Computed<String> _$fullNameComputed;

  @override
  String get fullName =>
      (_$fullNameComputed ??= Computed<String>(() => super.fullName)).value;

  final _$nomeAtom = Atom(name: '_UserProfile.nome');

  @override
  String get nome {
    _$nomeAtom.context.enforceReadPolicy(_$nomeAtom);
    _$nomeAtom.reportObserved();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.context.conditionallyRunInAction(() {
      super.nome = value;
      _$nomeAtom.reportChanged();
    }, _$nomeAtom, name: '${_$nomeAtom.name}_set');
  }

  final _$sobrenomeAtom = Atom(name: '_UserProfile.sobrenome');

  @override
  String get sobrenome {
    _$sobrenomeAtom.context.enforceReadPolicy(_$sobrenomeAtom);
    _$sobrenomeAtom.reportObserved();
    return super.sobrenome;
  }

  @override
  set sobrenome(String value) {
    _$sobrenomeAtom.context.conditionallyRunInAction(() {
      super.sobrenome = value;
      _$sobrenomeAtom.reportChanged();
    }, _$sobrenomeAtom, name: '${_$sobrenomeAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_UserProfile.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_UserProfile.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$nascimentoAtom = Atom(name: '_UserProfile.nascimento');

  @override
  DateTime get nascimento {
    _$nascimentoAtom.context.enforceReadPolicy(_$nascimentoAtom);
    _$nascimentoAtom.reportObserved();
    return super.nascimento;
  }

  @override
  set nascimento(DateTime value) {
    _$nascimentoAtom.context.conditionallyRunInAction(() {
      super.nascimento = value;
      _$nascimentoAtom.reportChanged();
    }, _$nascimentoAtom, name: '${_$nascimentoAtom.name}_set');
  }

  final _$sexoAtom = Atom(name: '_UserProfile.sexo');

  @override
  Sexo get sexo {
    _$sexoAtom.context.enforceReadPolicy(_$sexoAtom);
    _$sexoAtom.reportObserved();
    return super.sexo;
  }

  @override
  set sexo(Sexo value) {
    _$sexoAtom.context.conditionallyRunInAction(() {
      super.sexo = value;
      _$sexoAtom.reportChanged();
    }, _$sexoAtom, name: '${_$sexoAtom.name}_set');
  }

  final _$diagnosticosAtom = Atom(name: '_UserProfile.diagnosticos');

  @override
  ObservableList<String> get diagnosticos {
    _$diagnosticosAtom.context.enforceReadPolicy(_$diagnosticosAtom);
    _$diagnosticosAtom.reportObserved();
    return super.diagnosticos;
  }

  @override
  set diagnosticos(ObservableList<String> value) {
    _$diagnosticosAtom.context.conditionallyRunInAction(() {
      super.diagnosticos = value;
      _$diagnosticosAtom.reportChanged();
    }, _$diagnosticosAtom, name: '${_$diagnosticosAtom.name}_set');
  }

  final _$medicamentosAtom = Atom(name: '_UserProfile.medicamentos');

  @override
  ObservableList<Medicamento> get medicamentos {
    _$medicamentosAtom.context.enforceReadPolicy(_$medicamentosAtom);
    _$medicamentosAtom.reportObserved();
    return super.medicamentos;
  }

  @override
  set medicamentos(ObservableList<Medicamento> value) {
    _$medicamentosAtom.context.conditionallyRunInAction(() {
      super.medicamentos = value;
      _$medicamentosAtom.reportChanged();
    }, _$medicamentosAtom, name: '${_$medicamentosAtom.name}_set');
  }

  final _$_UserProfileActionController = ActionController(name: '_UserProfile');

  @override
  void deleteDiagnostico(String diagnostico) {
    final _$actionInfo = _$_UserProfileActionController.startAction();
    try {
      return super.deleteDiagnostico(diagnostico);
    } finally {
      _$_UserProfileActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addDiagnostico(String diagnostico) {
    final _$actionInfo = _$_UserProfileActionController.startAction();
    try {
      return super.addDiagnostico(diagnostico);
    } finally {
      _$_UserProfileActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteMedicamento(Medicamento medicamento) {
    final _$actionInfo = _$_UserProfileActionController.startAction();
    try {
      return super.deleteMedicamento(medicamento);
    } finally {
      _$_UserProfileActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMedicamento(Medicamento medicamento) {
    final _$actionInfo = _$_UserProfileActionController.startAction();
    try {
      return super.addMedicamento(medicamento);
    } finally {
      _$_UserProfileActionController.endAction(_$actionInfo);
    }
  }
}
