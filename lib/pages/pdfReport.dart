import 'dart:io';
import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/models/User.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart';

class PdfReport extends pw.Document {
  final UserProfile user;
  final List<RegistroHumor> data;

  _cardInfoText(String text) {
    return pw.Flexible(
        child: pw.Text(
      text,
      softWrap: true,
    ));
  }

  PdfReport({this.data, this.user}) : super() {
    this.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
            marginBottom: 2.5 * PdfPageFormat.cm,
            marginLeft: 2.5 * PdfPageFormat.cm,
            marginRight: 1.5 * PdfPageFormat.cm,
            marginTop: 2.5 * PdfPageFormat.cm),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: _pageHeader,
        footer: _pageFooter,
        build: (context) => [
              _user(context, user),
              pw.Header(level: 1, text: 'Afetivograma'),
              // _humorChart(context, data),
              pw.Header(level: 1, text: 'Registros de Humor'),
              ...data.map((e) => _humorEntry(context, e))
            ]));
  }

  pw.Widget _pageHeader(context) => pw.Header(
      level: 0,
      child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: <pw.Widget>[
            pw.Text(
              'Relatório Afetivo',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ]));

  pw.Widget _pageFooter(context) => null;

  var newFormat1 = DateFormat("dd/MM/yyyy");

  pw.Widget _user(context, UserProfile user) => pw.Column(children: [
        pw.Header(level: 1, text: 'Dados de Identificação'),
        pw.Row(
            children: [pw.Text('Nome: '), pw.Text(user.fullName.toString())]),
        pw.Row(children: [
          pw.Text('Data de Nascimento: '),
          pw.Text(newFormat1.format(user.nascimento))
        ]),
        pw.SizedBox(height: 20),
      ]);

  var newFormat2 = DateFormat("dd/MM/yyyy - HH:mm");

  pw.Widget _humorEntry(context, RegistroHumor humor) => pw.Wrap(children: [
        pw.Row(children: [
          pw.Text(
            describeTipoHumor(humor.tipo),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          )
        ]),
        pw.Row(children: [
          pw.Text('Data: '),
          pw.Text(newFormat2.format(humor.data))
        ]),
        pw.Row(children: [
          pw.Text('Disfórico: '),
          if (humor.disforico == true) _cardInfoText('sim')
        ]),
        pw.Row(children: [
          pw.Text('Nota Humor: '),
          if (humor.nota != null) _cardInfoText(humor.nota.toString())
        ]),
        pw.Row(children: [
          pw.Text('Horas Dormidas: '),
          if (humor.horasDormidas != null)
            _cardInfoText(humor.horasDormidas.toString())
        ]),
        pw.Row(children: [
          pw.Text('Em Periodo Menstrual: '),
          if (humor.periodoMenstrual != true) _cardInfoText('sim')
        ]),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text(
            'Evento de Vida: ',
            textAlign: pw.TextAlign.justify,
          ),
          if (humor.eventoDeVida != null)
            _cardInfoText(humor.eventoDeVida.toString())
        ]),
        pw.Row(children: [
          pw.Text('Impacto do evento: '),
          if (humor.eventoDeVida != null)
            _cardInfoText(humor.impactoEvento.toString())
        ]),
        pw.Row(children: [
          pw.Text('Sintomas Comorbidos: '),
          if (humor.sintomas != null) _cardInfoText(humor.sintomas.toString())
        ]),
        pw.Row(children: [
          pw.Text('Outras Informações: '),
          if (humor.otherInfo != null) _cardInfoText(humor.otherInfo.toString())
        ]),
        pw.SizedBox(height: 20),
      ]);

  // pw.Widget _humorChart(context, List<RegistroHumor> data) => pw.Chart(
  //         grid: pw.CartesianGrid(
  //             xAxis: pw.FixedAxis(
  //                 data.map((e) => e.data.microsecondsSinceEpoch).toList()),
  //             yAxis: pw.FixedAxis(data.map((e) => e.tipo.index).toList())),
  //         datasets: [
  //           pw.LineDataSet(
  //               isCurved: true,
  //               drawPoints: true,
  //               data: data
  //                   .map((e) => pw.LineChartValue(
  //                       e.data.microsecondsSinceEpoch.toDouble(),
  //                       e.tipo.index.toDouble()))
  //                   .toList())
  //         ]);

  Future<void> saveToFile(String path) async {
    final file = File(path);
    await file.writeAsBytes(this.save());
  }
}
