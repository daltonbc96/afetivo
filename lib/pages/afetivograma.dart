import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:afetivo/widgets/HumorCard.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Afetivograma extends StatelessWidget {
  static String tag = 'afetivograma-page';
  final _humorStore = HumorStore();

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Observer(
          builder: (context) => Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Material(
                            elevation: 10,
                            child: Container(
                              height: 250,
                              child: charts.TimeSeriesChart(
                                  [
                                    charts.Series<RegistroHumor, DateTime>(
                                      id: 'Humor',
                                      data: _humorStore.humorList,
                                      domainFn: (datum, index) => datum.data,
                                      colorFn: (datum, index) =>
                                          charts.ColorUtil.fromDartColor(
                                              Theme.of(context).accentColor),
                                      measureFn: (datum, index) =>
                                          datum.tipo.index,
                                      measureFormatterFn: (datum, index) =>
                                          (i) => describeTipoHumor(
                                              TipoHumor.values[i]),
                                    )
                                  ],
                                  animate: true,
                                  defaultRenderer: charts.LineRendererConfig(
                                      includePoints: true),
                                  primaryMeasureAxis: charts.NumericAxisSpec(
                                      tickFormatterSpec:
                                          charts.BasicNumericTickFormatterSpec(
                                              (i) => '')),
                                  behaviors: [
                                    charts.RangeAnnotation(TipoHumor.values
                                        .map((e) =>
                                            charts.LineAnnotationSegment(
                                                e.index,
                                                charts.RangeAnnotationAxisType
                                                    .measure,
                                                endLabel: describeTipoHumor(e),
                                                labelStyleSpec:
                                                    charts.TextStyleSpec(
                                                        fontSize: 10,
                                                        color:
                                                            charts
                                                                .MaterialPalette
                                                                .gray
                                                                .shade600),
                                                color: charts.MaterialPalette
                                                    .gray.shade200))
                                        .toList())
                                  ]),
                            ))),
                    Expanded(
                        child: ListView.builder(
                            itemCount: _humorStore.humorList.length,
                            itemBuilder: (context, index) {
                              return HumorCard(_humorStore.humorList[index]);
                            })),
                  ])));
}
