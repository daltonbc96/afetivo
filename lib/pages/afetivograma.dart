import 'package:afetivo/pages/adicionalInfo.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:afetivo/models/Humor.dart';

class Afetivograma extends StatelessWidget {
  static String tag = 'afetivograma-page';

  @override
  Widget build(BuildContext context) {
    final humorStore = Provider.of<HumorStore>(context);

    return new Scaffold(
        body: new Center(
            child: Observer(
                builder: (_) => ListView.builder(
                    itemCount: humorStore.humorList.length,
                    itemBuilder: (context, index) {
                      return _HumorCard(humorStore.humorList[index]);
                    }))));
  }
}

typedef Future<void> Callback(BuildContext context, RegistroHumor humor);

class _MenuOption {
  final String title;
  final Callback callback;

  _MenuOption(this.title, this.callback);
}

class _HumorCard extends StatefulWidget {
  final RegistroHumor humor;
  _HumorCard(this.humor);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<_HumorCard> {
  bool isExpanded;

  @override
  void initState() {
    this.isExpanded = false;
    super.initState();
  }

  @override
  void didUpdateWidget(_HumorCard oldWidget) {
    if (widget.humor != oldWidget.humor) {
      this.isExpanded = false;
    }
    super.didUpdateWidget(oldWidget);
  }

  _cardInfoText(String text) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            margin: new EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final humorStore = Provider.of<HumorStore>(context);
    final humor = widget.humor;
    final _menuItems = [
      _MenuOption("Editar", (context, humor) async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddicionalInfo(
                  humor: humor,
                )));
      }),
      _MenuOption("Remover", (context, humor) async {
        await humorStore.deleteHumor(humor);
      })
    ];

    return Observer(
        builder: (context) => Card(
                child: ExpansionPanelList(
                    expansionCallback: (_, isExpanded) => setState(() {
                          this.isExpanded = !isExpanded;
                        }),
                    children: [
                  ExpansionPanel(
                      headerBuilder: (context, isExpanded) => ListTile(
                            title: Text(describeTipoHumor(humor.tipo)),
                            subtitle: Text(DateFormat.yMd().format(humor.data)),
                          ),
                      body: Column(children: <Widget>[
                        if (humor.nota != null)
                          _cardInfoText("Nota do Humor: ${humor.nota}"),
                        if (humor.horasDormidas != null)
                          _cardInfoText(
                              "Horas Dormidas: ${humor.horasDormidas}"),
                        if (humor.periodoMenstrual)
                          _cardInfoText("Em Periodo Menstrual"),
                        if (humor.eventoDeVida != null)
                          _cardInfoText(
                              "Evento de Vida: ${humor.eventoDeVida}"),
                        if (humor.eventoDeVida != null)
                          _cardInfoText(
                              "Impacto do evento: ${humor.impactoEvento}"),
                        if (humor.sintomas != null)
                          _cardInfoText(
                              "Sintomas Comorbidos: ${humor.sintomas}"),
                        if (humor.otherInfo != null)
                          _cardInfoText(
                              "Outras Informações: ${humor.otherInfo}"),
                        ButtonBar(children: <Widget>[
                          PopupMenuButton<_MenuOption>(
                            itemBuilder: (context) => _menuItems
                                .map((item) => PopupMenuItem(
                                    value: item, child: Text(item.title)))
                                .toList(),
                            onSelected: (choice) =>
                                choice.callback(context, humor),
                          )
                        ])
                      ]),
                      isExpanded: isExpanded)
                ])));
  }
}
