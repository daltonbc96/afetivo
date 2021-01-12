import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/pages/adicionalInfo.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HumorSelector extends StatelessWidget {
  static String tag = 'home-page';
  final double _cardElevation = 8;
  final double _cardShadowOffset = 18;
  final humorStore = HumorStore();
  final PageController pageController =
      PageController(initialPage: 4, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;
    final _scrollController = ScrollController();
    final double _cardHeight = deviceHeight * 0.6;

    Widget getPageWidget(String text2, MaterialColor backgroundColor,
            String titulo, TipoHumor descHumor, TipoHumor tipoHumor) =>
        Container(
          height: _cardHeight,
          margin:
              EdgeInsets.only(left: 15, right: 15, bottom: _cardShadowOffset),
          child: Align(
              alignment: Alignment.topCenter,
              child: Material(
                elevation: _cardElevation,
                borderRadius: BorderRadius.circular(40.0),
                color: backgroundColor,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: _cardHeight * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          height: _cardHeight * 0.15,
                          child: Center(
                            child: Text(
                              describeTipoHumor(tipoHumor),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _cardHeight * 0.4,
                          child: Center(
                            child: Text(
                              text2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton.icon(
                              icon: Icon(Icons.check, color: Colors.white),
                              label: Text("Escolher Humor",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0)),
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0),
                              ),
                              color: Colors.green[700],
                              onPressed: () {
                                final humor = humorStore.createHumor(tipoHumor);
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => AddicionalInfo(
                                              humor: humor,
                                            )));
                              },
                            ),
                            FlatButton(
                              color: Colors.transparent,
                              child: Text('Estou com Dúvida',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              textColor: Colors.green[800],
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog

                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      title: new Text(titulo),
                                      insetPadding: EdgeInsets.symmetric(),
                                      content: Container(
                                          width: 400,
                                          height: 400,
                                          child: Scrollbar(
                                              controller:
                                                  _scrollController, // <---- Here, the controller
                                              isAlwaysShown: true,
                                              child: SingleChildScrollView(
                                                  controller: _scrollController,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      describeLongTipoHumor(
                                                        descHumor,
                                                      ),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          height: 1.5),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  )))),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                          color: Colors.green[700],
                                          child: new Text(
                                            "Entendi",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );

    return Container(
        margin: EdgeInsets.only(
            top: deviceHeight * 0.05, bottom: deviceHeight * 0.15),
        child: Material(
            type: MaterialType.transparency,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Como está seu Humor?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        height: 2,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      height: _cardHeight,
                      width: deviceWidth,
                      child: PageView(
                        controller: pageController,
                        children: [
                          getPageWidget(
                              "Essencialmente incapacitado ou hospitalizado",
                              Colors.lime,
                              "Depressão Grave",
                              TipoHumor.graveDepre,
                              TipoHumor.graveDepre),
                          getPageWidget(
                              "Funcionando com grande esforço",
                              Colors.lime,
                              "Depressão Moderada Alta",
                              TipoHumor.modGraveDepre,
                              TipoHumor.modGraveDepre),
                          getPageWidget(
                              "Funcionando com algum esforço",
                              Colors.lime,
                              "Depressão Moderada Baixa",
                              TipoHumor.modLeveDepre,
                              TipoHumor.modLeveDepre),
                          getPageWidget(
                              "Pouco ou nenhum prejuízo funcional",
                              Colors.lime,
                              "Depressão Leve",
                              TipoHumor.leveDepre,
                              TipoHumor.leveDepre),
                          getPageWidget(
                              "Sem alterações importantes",
                              Colors.lime,
                              "Estável",
                              TipoHumor.estavel,
                              TipoHumor.estavel),
                          getPageWidget(
                              "Mais energia e produtividade com pouco ou nenhum prejuízo funcional",
                              Colors.lime,
                              "Hipomania/Mania Leve",
                              TipoHumor.leveMania,
                              TipoHumor.leveMania),
                          getPageWidget(
                              "Alguma dificuldade em tarefas orientadas para um objetivo",
                              Colors.lime,
                              "Hipomania/Mania Moderada Baixa",
                              TipoHumor.modLeveMania,
                              TipoHumor.modLeveMania),
                          getPageWidget(
                              "Grande dificuldade em tarefas orientadas para um objetivo",
                              Colors.lime,
                              "Hipomania/Mania Moderada Alta",
                              TipoHumor.modGraveMania,
                              TipoHumor.modGraveMania),
                          getPageWidget(
                              "Essencialmente incapacitado ou hospitalizado",
                              Colors.lime,
                              "Hipomania/Mania Grave",
                              TipoHumor.graveMania,
                              TipoHumor.graveMania),
                        ],
                      )),
                ])));
  }
}
