import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:afetivo/models/Medicamento.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'Humor.g.dart';

enum TipoHumor {
  graveDepre,
  modGraveDepre,
  modLeveDepre,
  leveDepre,
  estavel,
  leveMania,
  modLeveMania,
  modGraveMania,
  graveMania
}

bool tipoHumorManiaco(TipoHumor tipoHumor) {
  switch (tipoHumor) {
    case TipoHumor.leveMania:
    case TipoHumor.modLeveMania:
    case TipoHumor.modGraveMania:
    case TipoHumor.graveMania:
      return true;
    default:
  }
  return false;
}

String describeTipoHumor(TipoHumor humor) {
  switch (humor) {
    case TipoHumor.graveDepre:
      return "Depressão Grave";
    case TipoHumor.modGraveDepre:
      return "Depressão Moderada Alta";
    case TipoHumor.modLeveDepre:
      return "Depressão Moderada Baixa";
    case TipoHumor.leveDepre:
      return "Depressão Leve";
    case TipoHumor.estavel:
      return "Estável";
    case TipoHumor.leveMania:
      return "Hipomania/Mania Leve";
    case TipoHumor.modLeveMania:
      return "Hipomania/Mania Moderada Baixa";
    case TipoHumor.modGraveMania:
      return "Hipomania/Mania Moderada Alta";
    case TipoHumor.graveMania:
      return "Hipomania/Mania Grave";
    default:
  }
  return '';
}

String describeLongTipoHumor(TipoHumor humor) {
  switch (humor) {
    case TipoHumor.graveDepre:
      return '''
◉	Descrição: no nível grave de depressão significa que você é incapaz de funcionar em qualquer uma de suas funções sociais e ocupacionais habituais, ou seja, é incapaz de sair da cama, ir para a escola ou trabalho, realizar qualquer uma das suas funções de rotina, exige muitos cuidados extras em casa, ou necessidade de ser hospitalizado.

◉	Sintomas: imobilizado; falta de autocuidado; má alimentação; baixa ingestão de líquidos; incapaz de se vestir; longos atrasos na fala ou mudo; muito agitado, andando de um lado para o outro; comportamento suicida; não consegue pensar ou lembrar; crenças falsas (delírios); distorções sensoriais (alucinações).

◉	Comprometimento Funcional: não está trabalhando ou indo a escola; não realiza atividades de casa; não consegue realizar qualquer atividade de rotina; está incapacitado em casa ou hospitalizado.
''';
    case TipoHumor.modGraveDepre:
      return '''
◉	Descrição: no nível moderada alta de depressão você pode perceber que suas habilidades funcionais são mais difíceis de serem realizadas, demandando de grande tempo extra ou grande esforço, pode apresentar também dificuldades em rotinas habituais.

◉	Sintomas: humor muito deprimido; sem esperança; falta de interesse; choroso; ansioso; irritável; concentração muito diminuída; energia muito baixa; diminuição da autoestima; sentimento de culpa; incapaz de aproveitar as coisas; nenhum interesse em coisas prazerosas; comportamento suicida; muita dificuldade para dormir; problemas com alimentação; retardo psicomotor e lentificação generalizada ou agitação psicomotora; diminuição do interesse/atividade sexual; bravo / irritável; socialmente retraído; isolamento social; pouca higiene.

◉	Comprometimento Funcional: muito esforço extra é necessário para executar atividades; prejuízo muito significativo no trabalho, na escola ou em casa; está faltando muitos dias no trabalho ou na escola.
''';
    case TipoHumor.modLeveDepre:
      return '''
◉ Descrição: no nível moderada baixa de depressão você pode perceber que suas habilidades funcionais, em alguns papéis habituais, são mais difíceis devido a sintomas de humor depressivo e requer tempo ou esforço extra para realizá-los.

◉ Sintomas: humor deprimido; sem esperança; falta de interesse; choroso; ansioso; irritável; concentração diminuída; diminuição de energia; diminuição da autoestima; sentimento de culpa; incapaz de aproveitar as coisas; nenhum interesse em coisas prazerosas; ideação suicida; dificuldades para dormir; problemas com alimentação; retardo psicomotor e lentificação generalizada ou agitação psicomotora; diminuição do interesse/atividade sexual; bravo; socialmente retraído; isolamento social.

◉ Comprometimento Funcional: necessita de um esforço extra para executar atividades; ocasionalmente falta alguns dias de trabalho ou escola; prejuízo notável no trabalho, escola e/ou casa.

      ''';
    case TipoHumor.leveDepre:
      return '''
◉	Descrição: o nível leve de depressão representa uma percepção subjetiva de sofrimento, um baixo-astral, alguns isolamentos sociais, mas continua com pouco ou nenhum comprometimento funcional.

◉	Sintomas: angústia subjetiva; humor triste leve; lentidão; “um pouco fora”; desinteresse leve; sono e apetite podem estar normais.

◉ Comprometimento Funcional: mínimo ou nenhum prejuízo; continua a exercer bem suas atividades no trabalho, escola e/ou em casa.
''';
    case TipoHumor.estavel:
      return '''
◉ Se você acredita que não teve alterações no humor e comprometimento funcional ao longo do dia, você pode marcar a opção "estável" (neutro).
''';
    case TipoHumor.leveMania:
      return '''
◉ Descrição: no nível leve de hipomania, você pode sentir sintomas de forma suave, como: diminuição da necessidade do sono, aumento de energia, alguma irritabilidade ou euforia; ou um aumento na taxa de pensamento, de expressão ou de sociabilidade. No nível leve, esses sintomas não têm impacto negativo e podem até, inicialmente, melhorar a sua capacidade funcional.
      
◉ Sintomas: aumento de energia; aumento de atividades; mais sociável; entusiasmado; exuberante; irritável; falador; sente-se mais produtivo.
          
◉ Comprometimento Funcional: mínimo ou nenhum prejuízo funcional; continua a realizar bem as atividades no trabalho, escola e/ou em casa; o funcionamento pode até melhorar em algumas áreas.
''';

    case TipoHumor.modLeveMania:
      return '''
◉ Descrição: no nível moderada baixa de mania pode apresentar os sintomas do nível de mania leve, com uma intensidade um pouco maior e com sintomas adicionais. Você pode apresentar menor produtividade e dificuldades de manter o foco. Você pode começar a receber algum feedback de familiares, amigos ou colegas de trabalho, que seu comportamento está diferente do habitual.

◉ Sintomas: eufórico; irritável; intrusivo; comunicativo; disfuncional; insistente; diminuição da necessidade de sono; aumento de energia; pressionado; fuga de ideias; distraído; aumento de gastos; excesso de velocidade; aumento do interesse / atividade sexual; promíscuo; grandioso; pode ser imprudente.

◉ Comprometimento Funcional: dificuldade com atividades objetivas; sente-se produtivo, mas sem efetivamente ser (por exemplo, inicia muitos projetos sem conseguir terminar); ter problemas com o trabalho, escola e família; as pessoas começam a comentar sobre o seu comportamento.
''';
    case TipoHumor.modGraveMania:
      return '''
◉ Descrição: no nível moderada alta de mania pode sentir sintomas muito significativos, como: muita diminuição da necessidade de sono (ou nem consegue dormir), um grande aumento no nível de energia, pode se sentir poderoso ou fora de controle, pode ter pensamentos e falas extremamente rápidos e receber muitos feedbacks que seu comportamento está diferente ou difícil. Outras pessoas podem expressar grandes preocupações com sua capacidade de cuidar de si mesmo ou dos outros, e podem parecer irritados ou frustrados com o seu comportamento.

◉ Sintomas: eufórico; irritável; intrusivo; muito comunicativo; disfuncional; insistente; diminuição da necessidade de sono; um grande aumento de energia; pressionado; fuga de ideias; muito distraído; um grande aumento de gastos; excesso de velocidade; um grande aumento do interesse/atividade sexual; promíscuo; grandioso; pode ser imprudente. 

◉ Comprometimento Funcional: não consegue se concentrar; as pessoas ficam zangadas/frustradas com você; o seu julgamento está pobre; você tem grande dificuldade com atividades objetivas.
''';
    case TipoHumor.graveMania:
      return '''
◉	Descrição: no nível grave do estado de humor maníaco há um aumento ainda maior dos sinais e sintomas descritos nos outros níveis, com muita insistência de familiares e amigos de que você precisa de atenção médica, que seu comportamento está fora de controle, ou eles podem levá-lo para um hospital. Há preocupações de que nem eles e nem você pode mantê-lo seguro por mais tempo. Se você estiver hospitalizado e com sintomas maníacos, marque este nível. 

◉	Sintomas: sente pouca ou nenhuma necessidade de sono; sente-se fora de controle; explosivo; sente-se todo poderoso; invencível; bravo; potencialmente violento; sente-se com energia excessiva; imprudente; vê ou ouve coisas que não existem realmente.

◉	Comprometimento Funcional: necessita de supervisão constante; pediu para se afastar do trabalho ou escola; é incapaz de executar quaisquer atividades objetivas; comportamento ou decisões bizarras; seus familiares e amigos insistem que você precisa buscar alguma ajuda; você pode ter problemas com leis; necessidade de hospitalização psiquiátrica.
''';
    default:
  }
  return '';
}

@JsonSerializable()
class RegistroHumor extends _RegistroHumor with _$RegistroHumor {
  RegistroHumor(
      {@required TipoHumor tipo,
      String id,
      bool disforico = false,
      DateTime data,
      int nota,
      List<RegistroMedicamento> medicamentos,
      int horasDormidas,
      bool periodoMenstrual = false,
      String eventoDeVida,
      double impactoEvento = 0,
      String sintomas,
      String otherInfo})
      : super(
            id: id ?? Uuid().v4(),
            tipo: tipo,
            disforico: disforico,
            data: data,
            nota: nota,
            medicamentos: ObservableList.of(medicamentos ?? []),
            horasDormidas: horasDormidas,
            periodoMenstrual: periodoMenstrual,
            eventoDeVida: eventoDeVida,
            impactoEvento: impactoEvento,
            sintomas: sintomas,
            otherInfo: otherInfo);

  RegistroHumor.from(RegistroHumor other)
      : super(
            id: other.id,
            tipo: other.tipo,
            disforico: other.disforico,
            data: other.data,
            nota: other.nota,
            medicamentos: other.medicamentos,
            horasDormidas: other.horasDormidas,
            periodoMenstrual: other.periodoMenstrual,
            eventoDeVida: other.eventoDeVida,
            impactoEvento: other.impactoEvento,
            sintomas: other.sintomas,
            otherInfo: other.otherInfo);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RegistroHumor.fromJson(Map<String, dynamic> json) =>
      _$RegistroHumorFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RegistroHumorToJson(this);
}

abstract class _RegistroHumor with Store {
  final String id;
  @observable
  TipoHumor tipo;
  @observable
  bool disforico;
  @observable
  DateTime data;
  @observable
  int nota;
  @observable
  @_ObservableListJsonConverter()
  ObservableList<RegistroMedicamento> medicamentos =
      ObservableList<RegistroMedicamento>();
  @observable
  int horasDormidas;
  @observable
  bool periodoMenstrual;
  @observable
  String eventoDeVida;
  @observable
  double impactoEvento;
  @observable
  String sintomas;
  @observable
  String otherInfo;

  _RegistroHumor(
      {@required this.id,
      this.tipo,
      this.disforico,
      this.data,
      this.nota,
      this.medicamentos,
      this.horasDormidas,
      this.periodoMenstrual,
      this.eventoDeVida,
      this.impactoEvento,
      this.sintomas,
      this.otherInfo}) {
    if (data == null) data = DateTime.now();
  }
}

class _ObservableListJsonConverter
    implements
        JsonConverter<ObservableList<RegistroMedicamento>,
            List<Map<String, dynamic>>> {
  const _ObservableListJsonConverter();

  @override
  ObservableList<RegistroMedicamento> fromJson(
          List<Map<String, dynamic>> json) =>
      ObservableList.of(json.map((x) => RegistroMedicamento.fromJson(x)));

  @override
  List<Map<String, dynamic>> toJson(ObservableList<RegistroMedicamento> list) =>
      list.map((x) => x.toJson()).toList();
}
