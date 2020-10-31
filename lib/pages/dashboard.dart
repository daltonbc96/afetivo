import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/pages/cadastroPage.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:afetivo/widgets/ExpandedSection.dart';
import 'package:afetivo/widgets/humorselector.dart';
import 'package:afetivo/widgets/HumorCard.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:afetivo/extensions/DateTime.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = 'DashboardScreen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _humorStore = HumorStore();
  final _loginStore = LoginStore();
  final _startDateFieldController = TextEditingController();
  final _endDateFieldController = TextEditingController();
  ReactionDisposer _filterReactor;

  final String title = 'Afetivo';

  @override
  void dispose() {
    _startDateFieldController.dispose();
    _endDateFieldController.dispose();
    _filterReactor();
    super.dispose();
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
            onPressed: _humorStore.toggleFilter,
            icon: Icon(
              Icons.date_range,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_downward,
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
              title: new Text("Configurações"),
              trailing: new Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pushNamed(CadastroPage.tag);
              },
            ),
            new ListTile(
              title: new Text("Ajuda"),
              trailing: new Icon(Icons.help_outline),
              onTap: () {
                Navigator.of(context).pushNamed("/help");
              },
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
                            controller: _startDateFieldController,
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
                            controller: _endDateFieldController,
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
                      defaultRenderer:
                          charts.LineRendererConfig(includePoints: true),
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
