import 'dart:io';
import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/models/User.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfReport extends pw.Document {
  final UserProfile user;
  final List<RegistroHumor> data;

  PdfReport({this.data, this.user}) : super() {
    this.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: _pageHeader,
        footer: _pageFooter,
        build: (context) => [
              _user(context, user),

              //_humorChart(context, data),
              ...data.map((e) => _humorEntry(context, e))
            ]));
  }

  pw.Widget _pageHeader(context) => null;

  pw.Widget _pageFooter(context) => null;

  pw.Widget _user(context, UserProfile user) => pw.Column(children: [
        pw.Row(
            children: [pw.Text('Nome: '), pw.Text(user.fullName.toString())]),
        pw.Row(children: [
          pw.Text('Data de Nascimento: '),
          pw.Text(user.nascimento.toString())
        ]),
        pw.SizedBox(height: 20),
      ]);

  pw.Widget _humorEntry(context, RegistroHumor humor) => pw.Column(children: [
        pw.Row(children: [pw.Text('Data: '), pw.Text(humor.data.toString())]),
        pw.Row(children: [
          pw.Text('Humor: '),
          pw.Text(describeTipoHumor(humor.tipo))
        ]),
        pw.SizedBox(height: 20),
      ]);

  pw.Widget _humorChart(context, List<RegistroHumor> data) => pw.Chart(
          grid: pw.CartesianGrid(
              xAxis: pw.FixedAxis(
                  data.map((e) => e.data.microsecondsSinceEpoch).toList()),
              yAxis: pw.FixedAxis(data.map((e) => e.tipo.index).toList())),
          datasets: [
            pw.LineDataSet(
                isCurved: true,
                drawPoints: true,
                data: data
                    .map((e) => pw.LineChartValue(
                        e.data.microsecondsSinceEpoch.toDouble(),
                        e.tipo.index.toDouble()))
                    .toList())
          ]);

  Future<void> saveToFile(String path) async {
    final file = File(path);
    await file.writeAsBytes(this.save());
  }
}
