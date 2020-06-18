// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Medicamento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicamento _$MedicamentoFromJson(Map<String, dynamic> json) {
  return Medicamento(
    nome: json['nome'] as String,
    dose: json['dose'] as String,
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
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$doseAtom = Atom(name: '_Medicamento.dose');

  @override
  String get dose {
    _$doseAtom.reportRead();
    return super.dose;
  }

  @override
  set dose(String value) {
    _$doseAtom.reportWrite(value, super.dose, () {
      super.dose = value;
    });
  }

  @override
  String toString() {
    return '''
nome: ${nome},
dose: ${dose}
    ''';
  }
}

mixin _$RegistroMedicamento on _RegistroMedicamento, Store {
  final _$medicamentoAtom = Atom(name: '_RegistroMedicamento.medicamento');

  @override
  Medicamento get medicamento {
    _$medicamentoAtom.reportRead();
    return super.medicamento;
  }

  @override
  set medicamento(Medicamento value) {
    _$medicamentoAtom.reportWrite(value, super.medicamento, () {
      super.medicamento = value;
    });
  }

  final _$numeroComprimidosAtom =
      Atom(name: '_RegistroMedicamento.numeroComprimidos');

  @override
  int get numeroComprimidos {
    _$numeroComprimidosAtom.reportRead();
    return super.numeroComprimidos;
  }

  @override
  set numeroComprimidos(int value) {
    _$numeroComprimidosAtom.reportWrite(value, super.numeroComprimidos, () {
      super.numeroComprimidos = value;
    });
  }

  @override
  String toString() {
    return '''
medicamento: ${medicamento},
numeroComprimidos: ${numeroComprimidos}
    ''';
  }
}
