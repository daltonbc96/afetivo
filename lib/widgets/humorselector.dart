import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/pages/adicionalInfo.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HumorSelector extends StatefulWidget {
  _HumorSelectorState createState() => _HumorSelectorState();
  static String tag = 'home-page';
}

class _HumorSelectorState extends State<HumorSelector> {
  @override
  Widget build(BuildContext context) {
    //final Widget body = Column(children: [pageView,]);
    final humorStore = HumorStore();

    final PageController pageController =
        PageController(initialPage: 4, viewportFraction: 0.8);

    Widget getPageWidget(String text2, MaterialColor backgroundColor,
            String titulo, String descricao, TipoHumor tipoHumor) =>
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(40.0),
                color: backgroundColor,
                child: Align(
                  //alignment: Alignment(0.0, 0.7),
                  child: Container(
                    height: 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          describeTipoHumor(tipoHumor),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          text2,
                          style: TextStyle(
                            fontSize: 14.0,
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
                                      color: Colors.white, fontSize: 16.0)),
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
                                  style: TextStyle(fontSize: 16)),
                              textColor: Colors.white,
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
                                      content: new Text(descricao),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("Entendi"),
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
              )
            ],
          ),
        );

    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: (deviceHeight - 400) / 2),
      child: PageView(
        controller: pageController,
        children: [
          getPageWidget(" Descrição do humor", Colors.amber, "page1",
              "descrição 1", TipoHumor.graveDepre),
          getPageWidget(" Descrição do humor", Colors.lightBlue, "page2",
              "descrição 2", TipoHumor.modGraveDepre),
          getPageWidget(" Descrição do humor", Colors.lime, "page3",
              "descrição 3", TipoHumor.modLeveDepre),
          getPageWidget(" Descrição do humor", Colors.lime, "page4",
              "descrição 4", TipoHumor.leveDepre),
          getPageWidget(" Descrição do humor", Colors.lime, "page5",
              "descrição 5", TipoHumor.estavel),
          getPageWidget(" Descrição do humor", Colors.lime, "page6",
              "descrição 6", TipoHumor.leveMania),
          getPageWidget(" Descrição do humor", Colors.lime, "page7",
              "descrição 7", TipoHumor.modLeveMania),
          getPageWidget(" Descrição do humor", Colors.lime, "page8",
              "descrição 8", TipoHumor.modGraveMania),
          getPageWidget(" Descrição do humor", Colors.lime, "page9",
              "descrição 9", TipoHumor.graveMania),
        ],
      ),
    );
  }
}
