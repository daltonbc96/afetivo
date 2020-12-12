import 'dart:ui';

import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/pages/cadastroPage.dart';
import 'package:afetivo/pages/reportViewer.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:afetivo/widgets/ExpandedSection.dart';
import 'package:afetivo/widgets/humorselector.dart';
import 'package:afetivo/widgets/HumorCard.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:afetivo/extensions/DateTime.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = 'DashboardScreen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _humorStore = HumorStore();
  final _loginStore = LoginStore();
  ReactionDisposer _filterReactor;

  final String title = 'Afetivo';

  @override
  void dispose() {
    _filterReactor();
    super.dispose();
  }

  //coah marks - tutorial inicial
  TutorialCoachMark tutorialCoachMark; // class variable
  List<TargetFocus> targets = List(); // list of targets

  // all target keys
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();
  GlobalKey key5 = GlobalKey();

  //functions

  @override
  void initState() {
    initTarget();
    // WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    super.initState();
  }

  // void _afterLayout(_) {
  //   Future.delayed(Duration(milliseconds: 100));
  //   showTutorial();
  // }

  // void showTutorial() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var intro = preferences.getBool('intro') ?? false;
  //   if (!intro) {
  //     tutorialCoachMark = TutorialCoachMark(
  //       context,
  //       targets: targets,
  //       colorShadow: Colors.green,
  //       opacityShadow: 0.85,
  //       textSkip: "Pular Tutorial",
  //       onFinish: () => preferences.setBool('intro', true),
  //     )..show();
  //   }
  // }

  void initTarget() {
    targets.add(
      TargetFocus(identify: "Target 1", keyTarget: key1, contents: [
        ContentTarget(
          align: AlignContent.top,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Adicionar um Novo Humor",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Text(
                    'Clique nesse botão para adicionar um novo humor. Escolha um dos cartões que melhor represente o seu humor hoje.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ),
      ]),
    );

    targets.add(
      TargetFocus(identify: "Target 2", keyTarget: key2, contents: [
        ContentTarget(
          align: AlignContent.top,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Visualização",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Text(
                    'Nessa área será mostrado os seus registros de humor. Aqui também é possível editar e excluir seus registros.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ),
      ]),
    );

    targets.add(
      TargetFocus(identify: "Target 3", keyTarget: key3, contents: [
        ContentTarget(
          align: AlignContent.bottom,
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  "Afetivograma",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Aqui será exibido o seu afetivograma. O afetivograma é um tipo de gráfico que mostrará a variação do seu humor ao longo do tempo.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );

    targets.add(
      TargetFocus(identify: "Target 4", keyTarget: key4, contents: [
        ContentTarget(
          align: AlignContent.bottom,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Filtrar Dados",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Text(
                    'Clique nesse botão para filtrar o período que deseja visualizar no gráfico. Para filtrar escolha uma data inicial e uma data final',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ),
      ]),
    );

    targets.add(
      TargetFocus(identify: "Target 5", keyTarget: key5, contents: [
        ContentTarget(
          align: AlignContent.bottom,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Exportar Dados",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Text(
                    'Clique nesse botão para exportar e compartilhar os seus registros.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          title,
        ),
        actions: <Widget>[
          IconButton(
            key: key4,
            onPressed: _humorStore.toggleFilter,
            icon: Icon(
              Icons.date_range,
            ),
          ),
          IconButton(
            key: key5,
            onPressed: () => Navigator.of(context).pushNamed(ReportViewer.tag),
            icon: Icon(
              Icons.picture_as_pdf,
            ),
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            Observer(builder: (context) {
              final userProfile = _loginStore.userProfile;
              return _loginStore.userProfile != null
                  ? UserAccountsDrawerHeader(
                      accountName: new Text(userProfile.fullName),
                      accountEmail: new Text(userProfile.email),
                      currentAccountPicture: new CircleAvatar(
                        backgroundColor: Colors.green[300],
                        child: new Text((userProfile.nome[0] ?? '') +
                            (userProfile.sobrenome[0] ?? '')),
                      ),
                    )
                  : SizedBox.shrink();
            }),
            new ListTile(
              title: new Text("Cadastro"),
              trailing: new Icon(Icons.account_circle_sharp),
              onTap: () {
                Navigator.of(context).pushNamed(CadastroPage.tag);
              },
            ),
            new ListTile(
              title: new Text("Ajuda"),
              trailing: new Icon(Icons.help_outline),
              onTap: () => Navigator.of(context).pushNamed("/help"),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Sair"),
              trailing: new Icon(Icons.close),
              onTap: _loginStore.logout,
            ),
          ],
        ),
      ),
      body: Observer(
        builder: (context) =>
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ExpandedSection(
            expand: _humorStore.filtered,
            child: Container(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DateTimeField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              labelText: "Data Inicial",
                            ),
                            format:
                                DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_BR'),
                            onChanged: (value) => _humorStore.startDate = value,
                            onShowPicker: (context, currentValue) =>
                                showDatePicker(
                                  context: context,
                                  firstDate:
                                      _humorStore.humorList.last.data.date,
                                  initialDate: currentValue ??
                                      _humorStore.humorList.last.data.date,
                                  lastDate: _humorStore.endDate ??
                                      _humorStore.humorList.first.data.date,
                                ))),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DateTimeField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              labelText: "Data Final",
                            ),
                            format:
                                DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_BR'),
                            onChanged: (value) => _humorStore.endDate = value,
                            onShowPicker: (context, currentValue) =>
                                showDatePicker(
                                  context: context,
                                  firstDate: _humorStore.startDate ??
                                      _humorStore.humorList.last.data.date,
                                  initialDate: currentValue ??
                                      _humorStore.humorList.first.data.date,
                                  lastDate:
                                      _humorStore.humorList.first.data.date,
                                ))),
                  ],
                )),
          ),
          GestureDetector(
              onVerticalDragUpdate: (detail) {
                if ((_humorStore.filtered && detail.delta.dy < -5) ||
                    (!_humorStore.filtered && detail.delta.dy > 5))
                  _humorStore.toggleFilter();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Material(
                  elevation: 10,
                  child: Container(
                    key: key3,
                    height: 250,
                    child: charts.TimeSeriesChart(
                      [
                        charts.Series<RegistroHumor, DateTime>(
                          id: 'Humor',
                          data: _humorStore.filteredHumors,
                          domainFn: (datum, index) => datum.data,
                          colorFn: (datum, index) =>
                              charts.ColorUtil.fromDartColor(
                                  Theme.of(context).accentColor),
                          measureFn: (datum, index) => datum.tipo.index,
                          measureFormatterFn: (datum, index) =>
                              (i) => describeTipoHumor(TipoHumor.values[i]),
                        )
                      ],
                      animate: false,
                      /*selectionModels: [charts.SelectionModelConfig(changedListener: (d) {

                      })],*/
                      defaultRenderer:
                          charts.LineRendererConfig(includePoints: true),
                      domainAxis: charts.DateTimeAxisSpec(
                        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                          day: charts.TimeFormatterSpec(
                            format: 'dd/MM',
                            transitionFormat: 'dd/MM/yyyy',
                          ),
                          month: charts.TimeFormatterSpec(
                            format: 'MM/yyyy',
                            transitionFormat: 'MM/yyyy',
                          ),
                        ),
                      ),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                          tickFormatterSpec:
                              charts.BasicNumericTickFormatterSpec((i) => '')),
                      behaviors: [
                        charts.RangeAnnotation(TipoHumor.values
                            .map((e) => charts.LineAnnotationSegment(
                                e.index, charts.RangeAnnotationAxisType.measure,
                                endLabel: describeTipoHumor(e),
                                labelStyleSpec: charts.TextStyleSpec(
                                    fontSize: 10,
                                    color:
                                        charts.MaterialPalette.gray.shade600),
                                color: charts.MaterialPalette.gray.shade200))
                            .toList())
                      ],
                    ),
                  ),
                ),
              )),
          Expanded(
            key: key2,
            child: ListView.builder(
              itemCount: _humorStore.filteredHumors.length,
              itemBuilder: (context, index) {
                return HumorCard(_humorStore.filteredHumors[index]);
              },
            ),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        key: key1,
        child: Icon(Icons.add),

        onPressed: () {
          showDialog(context: context, builder: (context) => HumorSelector());
        },
        tooltip: 'Increment',
        // elevation: 2.0,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.green,
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}

//References
//https://github.com/DeveloperLibs/flutter_bottom_bar_navigation
//https://github.com/javico2609/flutter-challenges/blob/master/lib/pages/code_examples/pdf_and_csv/pdf.dart
