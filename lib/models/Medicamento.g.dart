// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Medicamento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicamento _$MedicamentoFromJson(Map<String, dynamic> json) {
  return Medicamento(
    nome: json['nome'] as String,
    dose: (json['dose'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MedicamentoToJson(Medicamento instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'dose': instance.dose,
    };

RegistroMedicamento _$RegistroMedicamentoFromJson(Map<String, dynamic> json) {
  return RegistroMedicamento(
    medicamento: json['medicamento'] == null
        ? null
        : Medicamento.fromJson(json['medicamento'] as Map<String, dynamic>),
    numeroComprimidos: json['numeroComprimidos'] as int,
  );
}

Map<String, dynamic> _$RegistroMedicamentoToJson(
        RegistroMedicamento instance) =>
    <String, dynamic>{
      'medicamento': instance.medicamento?.toJson(),
      'numeroComprimidos': instance.numeroComprimidos,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Medicamento on _Medicamento, Store {
  final _$nomeAtom = Atom(name: '_Medicamento.nome');

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

  final _$doseAtom = Atom(name: '_Medicamento.dose');

  @override
  double get dose {
    _$doseAtom.context.enforceReadPolicy(_$doseAtom);
    _$doseAtom.reportObserved();
    return super.dose;
  }

  @override
  set dose(double value) {
    _$doseAtom.context.conditionallyRunInAction(() {
      super.dose = value;
      _$doseAtom.reportChanged();
    }, _$doseAtom, name: '${_$doseAtom.name}_set');
  }
}

mixin _$RegistroMedicamento on _RegistroMedicamento, Store {
  final _$medicamentoAtom = Atom(name: '_RegistroMedicamento.medicamento');

  @override
  Medicamento get medicamento {
    _$medicamentoAtom.context.enforceReadPolicy(_$medicamentoAtom);
    _$medicamentoAtom.reportObserved();
    return super.medicamento;
  }

  @override
  set medicamento(Medicamento value) {
    _$medicamentoAtom.context.conditionallyRunInAction(() {
      super.medicamento = value;
      _$medicamentoAtom.reportChanged();
    }, _$medicamentoAtom, name: '${_$medicamentoAtom.name}_set');
  }

  final _$numeroComprimidosAtom =
      Atom(name: '_RegistroMedicamento.numeroComprimidos');

  @override
  int get numeroComprimidos {
    _$numeroComprimidosAtom.context.enforceReadPolicy(_$numeroComprimidosAtom);
    _$numeroComprimidosAtom.reportObserved();
    return super.numeroComprimidos;
  }

  @override
  set numeroComprimidos(int value) {
    _$numeroComprimidosAtom.context.conditionallyRunInAction(() {
      super.numeroComprimidos = value;
      _$numeroComprimidosAtom.reportChanged();
    }, _$numeroComprimidosAtom, name: '${_$numeroComprimidosAtom.name}_set');
  }
}
