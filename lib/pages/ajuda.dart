import 'package:afetivo/pages/tutorial.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:flutter/material.dart';

class Ajuda extends StatefulWidget {
  final String title;

  Ajuda(this.title);
  @override
  _Ajuda createState() => _Ajuda();
}

class MyItem {
  MyItem({this.isExpanded: false, this.header, this.body});

  bool isExpanded;
  final String header;
  final Widget body;
}

class _Ajuda extends State<Ajuda> {
  static final _loginStore = LoginStore();

  List<MyItem> _items;

  @override
  void initState() {
    super.initState();
    _items = <MyItem>[
      MyItem(
          header: "O que é o app afetivo?",
          body: Text(
            'O afetivo é um aplicativo que objetiva auxiliar pessoas no automonitoramento de humor. O método utilizado nesse aplicativo foi inspirado no protocolo desenvolvido pelo National Institute of Mental Health (NIMH), o Life Chart Method - Self/Prospective (LCM-S/P).',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: 'Vídeo de Apresentação',
          body: Container(
              child: ListBody(children: [
            Text("Para assistir o vídeo de apresentação clique em 'Assitir'"),
            MaterialButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0)),
                height: 40.0,
                minWidth: 70.0,
                textColor: Colors.green,
                child: new Text("Assitir", style: TextStyle(fontSize: 16.0)),
                onPressed: () =>
                    Navigator.of(context).pushNamed(TutorialPage.tag)),
          ]))),
      MyItem(
          header: "O que é humor?",
          body: Text(
            'O humor é o background (experiência/pano de fundo), que se caracteriza por apresentar baixa intensidade e duração maior que as emoções, afetando o funcionamento da pessoa de forma global. O humor pode influenciar as emoções e vice-versa. Por exemplo, quando um colega crítica você pela forma como falou com um cliente, você pode experienciar e/ou demonstrar uma emoção (raiva) em relação a um objeto específico (seu colega). No entanto, conforme a emoção vai diminuindo, você pode se sentir desanimado de maneira geral. Você começa a perceber que esse estado de desânimo não é o seu estado normal e começa a exagerar em relação a outros eventos. Esse estado se caracteriza como um humor. Outros exemplos de humor são: animação ou desânimo e estado de alta ou diminuição de energia.',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: "Quando as alterações do humor \nse tornam problemáticas?",
          body: Text(
            '''O humor pode ser entendido como o estado de ânimo ou estado de espírito de uma pessoa, o qual costuma sofrer alterações no dia a dia. No entanto, para algumas pessoas, estas variações são mais importantes e persistentes, trazendo prejuízos para a vida do indivíduo. Esses quadros são chamados de Transtornos de Humor, e podem se manifestar através de sintomas depressivos (com ou sem ansiedade associada) ou sintomas maníacos (elevação do humor). 

Quando a pessoa apresenta diminuições importantes e persistentes do humor, dizemos que seu humor está deprimido. Já quando a pessoa apresenta elevação do humor, dizemos que seu humor está maníaco ou hipomaníaco.

Esses sintomas (depressivos ou maníacos) podem gerar sintomas secundários como alterações no sono, aumento do peso e menor rendimento no trabalho. Quando não diagnosticado ou tratado corretamente, os Transtornos de Humor podem ocasionar prejuízos em diferentes aspectos da vida, como a perda do emprego, a baixa produtividade e a exposição a situações de risco. Consulte o seu médico ou terapeuta para ter mais detalhes.''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header:
              "Quais são os sintomas comuns \nde Mania/Hipomania e \nDepressão?",
          body: Text(
            '''Sintomas Comuns de Mania/ Hipomania:

- Aumento de energia; 
- Sente-se agitado ou com o humor irritável; 
- Autoestima inflada ou sentimento de grandiosidade; 
- Diminuição da necessidade de sono; 
-Sentir que tem falado mais que o habitual ou sentir uma pressão para continuar falando; 
-Fuga de ideias ou pensamento acelerado; 
-Facilmente distraído;
- Envolvimento excessivo em atividade prazerosa (gastos excessivos, atividade sexual, investimentos financeiros tolos).

Sintomas Comuns de Depressão:

-Diminuição de energia; 
-Humor deprimido, sentimento de vazio, tristeza; 
-Diminuição do interesse ou prazer em atividades habituais; 
-Dificuldade de concentração; 
-Significativo ganho ou perda de peso;
-Mudança nos padrões de sono, incapacidade de dormir ou aumento dos períodos de sono;
-Sentimento de inutilidade ou culpa inadequada; 
-Dificuldade em tomar decisões; 
-Pensamentos recorrentes de morte ou suicídio. 
''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: '''Como identificar a intensidade \ndo meu humor?''',
          body: Text(
            ''' Os sintomas de mania, hipomania e depressão podem ser diferentes em cada pessoa. Esses sintomas podem durar algum período, podendo durar algumas semanas, mudar na mesma semana ou, até mesmo, no mesmo dia. 

Para saber a intensidade do seu humor observe como o seu humor afetou sua capacidade de atuar em seus papéis sociais e ocupacionais habituais (como em casa, no trabalho ou na escola). 

Você, então, deve avaliar o quanto o seu humor tem afetado sua capacidade de funcionar durante o dia a dia em seus papéis habituais em casa, trabalho, escola e/ou com amigos. A intensidade ou a gravidade do humor é determinada com base no seu nível de comprometimento funcional (por exemplo: dificuldades com papéis sociais, educacionais e/ou ocupacionais), que é afetado com a presença de sintomas depressivos ou maníacos/ hipomaníacos. Tire dois minutos, ao final do seu dia, e realize a avaliação do seu humor ao longo do dia. Preencha o círculo para realizar a marcação do seu humor.

Utilize a opção “estou com dúvida” em cada cartão para visualizar a descrição de cada intensidade de humor. 

Note que o comprometimento funcional, devido a outras doenças médicas, como uma gripe, uma perna quebrada, artrite, doenças cardíacas, entre outras, estes não devem ser levados em conta para avaliar a intensidade do seu humor.

Se você acredita que não teve alterações no humor e comprometimento funcional ao longo do dia, você pode marcar a opção "estável" (neutro). 
''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: '''Lista de Medicamentos''',
          body: Text(
            '''Com a ajuda de algum profissional da saúde, liste os medicamentos que seu médico prescreveu nos espaços fornecidos, incluindo o nome do medicamento e a dosagem. A cada dia, indique o número exato de comprimidos que tomou de cada medicamento no espaço adequado. Liste todos os medicamentos que você ingeriu durante o dia incluindo psiquiátricos e não psiquiátricos.

Caso necessite adicionar um novo medicamento na sua lista, vai no seu perfil e adicione um novo medicamento. 
 ''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: '''Horas de Sono''',
          body: Text(
            '''Anote o número de horas que você dormiu na noite anterior.''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: '''O que é mania disfórica? ''',
          body: Text(
            '''É quando você experiencia sintomas de mania/hipomania associados com raiva, irritabilidade ou ansiedade. Esse estado energizado é desagradável ou disfórico, por tanto, você deve marcar nas informações adicionais a opção de Mania Disfórica.''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: '''Como criar uma lista própria \nde sintomas? ''',
          body: Text(
            '''Além dos sintomas clássicos de depressão e mania/hipomania, você também pode desenvolver sua própria lista de sintomas típicos. Por exemplo, em algumas pessoas, o melhor marcador de hipomania pode ser o aumento de energia, enquanto, em outras, pode ser a diminuição da necessidade de sono ou maior sociabilidade, telefonemas ou gastos. Da mesma forma, para a depressão, algumas pessoas sentem -se lentas ou apáticas, enquanto outras se sentem agitadas. Algumas pessoas dormem mais, enquanto outras não conseguem dormir muito. Outras têm a impressão de que sua mente está vazia, enquanto outras são atormentadas por pensamentos depressivos.

Ter a própria lista de seus sintomas típicos pode servir como um sistema próprio de alerta precoce, que pode auxiliar você e seu clínico a estarem mais conscientes dos sinais de suas alterações de humor. Dessa forma, você pode intervir desde cedo, antes que os sintomas fiquem fora de controle, perguntando ao seu clínico ou terapeuta como proceder.
 ''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: '''Como avaliar o meu humor \nde forma geral? ''',
          body: Text(
            '''Nas informações adicionais há uma opção para avaliar o seu humor de forma geral. Trata-se de uma segunda avaliação sobre a intensidade do seu humor, porém com base em uma escala que vai de a 100. Considere 0 como o valor para o mais depressivo possível, 50 para equilibrado (neutro) e 100 o mais maníaco possível. Você pode escolher um valor dentro desses intervalos que melhor represente o seu humor.  ''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header:
              '''Quando exatamente devo marcar \nque estou no ciclo menstrual? ''',
          body: Text(
            '''Ao registrar o seu humor, nas informações adicionais, marque se você está no seu período menstrual naquele dia.''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: '''Que tipo de evento de vida \ndevo anotar? ''',
          body: Text(
            '''Eventos de vida são todas as situações e acontecimentos que ocorreram ao longo do seu dia e que você considera relevantes.

Atenção, ao registrar um evento de vida anote também o impacto que esse evento teve na sua vida, seguindo uma escala de -4 a +4. Considere -4 como uma experiência extremamente negativa, 0 como uma experiência neura e +4 uma experiência extremamente positiva. Você pode escolher um valor dentro desses intervalos que melhor represente o impacto que esse evento teve na sua vida.  
''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: '''O que são sintomas comórbidos?''',
          body: Text(
            '''Sintomas comórbidos são sintomas que aparecem ao longo do dia além dos sintomas de humor (como ansiedade, abuso de álcool, paranoia, dor de cabeça, entre outros). Anote todos esses sintomas adicionais que você pode ter experenciado ao longo dia na opção “sintomas comórbidos” nas informações adicionais. 

Se aplicável, continue a indicar a presença e a frequência desses sintomas nos dias subsequentes (por exemplo, número de ataques de pânico, número de bebidas alcoólicas, etc.).
''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: '''O que é um afetivograma? ''',
          body: Text(
            '''Uma das formas de anotar e acompanhar o humor é por meio da construção de gráficos, como os afetivogramas. Com esse modelo de anotação, é possível visualizar graficamente as alterações de humor em uma linha do tempo.''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header:
              '''O que é o Life Chart Method - \nSelf/Prospective (LCM-S/P)?''',
          body: Text(
            '''É um método de anotações de humor e construção de afetivogramas desenvolvido pelo National Institute of Mental Health (NIMH). Esse método se destaca pela sua flexibilidade em diferentes contextos e possibilita a inclusão de diversas outras informações.''',
            style: TextStyle(fontSize: 14, height: 1.5),
          )),
      MyItem(
          header: 'Como posso excluir minha conta?',
          body: Container(
              child: ListBody(children: [
            Text("Para excluir sua conta clique no botão a baixo."),
            MaterialButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0)),
                height: 40.0,
                minWidth: 70.0,
                textColor: Colors.red,
                child:
                    new Text("Excluir Conta", style: TextStyle(fontSize: 16.0)),
                onPressed: () async {
                  return showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => AlertDialog(
                              title: Text("Deletar Conta"),
                              content: SingleChildScrollView(
                                  child: ListBody(
                                children: [
                                  Text(
                                      "Você tem certeza que deseja deletar sua conta?"),
                                  Text("Esta ação não poderá ser desfeita.")
                                ],
                              )),
                              actions: [
                                TextButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: Text("Cancelar e Voltar")),
                                TextButton(
                                    onPressed: _loginStore.deleteUser,
                                    child: Text("Excluir Conta")),
                              ]));
                }),
          ]))),
    ];
  }

  Widget _buildListPanel() {
    return Card(
        elevation: 10,
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _items[index].isExpanded = !_items[index].isExpanded;
            });
          },
          children: _items.map((MyItem item) {
            return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                      padding: EdgeInsets.all(10.0),
                      child: new Row(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(item.header,
                                    style: TextStyle(fontSize: 16))))
                      ]));
                },
                isExpanded: item.isExpanded,
                body: Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                  child: item.body,
                ));
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Ajuda'),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: _buildListPanel(),
            margin: new EdgeInsets.symmetric(horizontal: 2),
          ),
        ),
      ),
    );
  }
}
