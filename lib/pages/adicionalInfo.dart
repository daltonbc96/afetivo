import 'package:flutter/material.dart';
import '../main.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddicionalInfo extends StatefulWidget {
  static String tag = 'tag-pageAddInfo';

  @override
  _State createState() => _State();
}

class _State extends State<AddicionalInfo> {
  double mCurrentValue = 50.0;
  double currentValue = 0.0;
  String resposta = 'Não';
  @override
  Widget build(BuildContext context) {
    String _date = "Not set";
    final data = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(),
              onTap: () {
                DatePicker.showDatePicker(context,
                    theme: DatePickerTheme(
                      containerHeight: 210.0,
                    ),
                    showTitleActions: true,
                    minTime: DateTime(1900, 01, 01),
                    maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
                  print("confirme $date");
                  _date = '${date.day} - ${date.month} - ${date.year}';
                  setState(() {});
                }, currentTime: DateTime.now(), locale: LocaleType.pt);
              },
            )
          ],
        ),
      ),
    );

    final sentBtt = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: new MaterialButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0)),
          height: 40.0,
          minWidth: 70.0,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: new Text("CADASTRAR", style: TextStyle(fontSize: 16.0)),
          onPressed: () =>
              {Navigator.of(context).pushNamed(DashboardScreen.tag)},
          splashColor: Colors.redAccent,
        ));

    final notaHumor = SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.deepOrangeAccent,
        activeTickMarkColor: Colors.white,
        inactiveTickMarkColor: Colors.white,
        inactiveTrackColor: Colors.black,
        valueIndicatorColor: Colors.green,
        thumbColor: Colors.green,
        overlayColor: Colors.amber,
      ),
      child: new Container(
        margin: const EdgeInsets.all(10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Depressão',
              textAlign: TextAlign.left,
            ),
            new Expanded(
                child: new Slider(
              onChanged: (double value) {
                setState(() {
                  mCurrentValue = value;
                });
              },
              divisions: null,
              min: 0,
              max: 100,
              label: '$mCurrentValue',
              value: mCurrentValue,
            )),
            new Text(
              'Mania',
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );

    final medicamentos = Container(
        child: Column(
      children: <Widget>[
        TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            labelText: 'Medicamentos',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ],
    ));

    final horasDormidas = Container(
        child: Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          decoration: InputDecoration(
            labelText: 'Horas Dormidas',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ],
    ));

    final menstrual = Container(
        child: Column(children: <Widget>[
      Text("Você está no Período Menstrual ?"),
      DropdownButton<String>(
        hint: Text("Período Menstrual"),
        isExpanded: true,
        value: resposta,
        onChanged: (String newValue) {
          setState(() {
            resposta = newValue;
          });
        },
        items: <String>['Não', 'Sim']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    ]));

    final eventos = Container(
        child: Column(
      children: <Widget>[
        TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            labelText: 'Eventos de Vida',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ],
    ));

    final impacto = SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.deepOrangeAccent,
        activeTickMarkColor: Colors.white,
        inactiveTickMarkColor: Colors.white,
        inactiveTrackColor: Colors.black,
        valueIndicatorColor: Colors.green,
        thumbColor: Colors.green,
        overlayColor: Colors.amber,
      ),
      child: new Container(
        margin: const EdgeInsets.all(10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '-4.0',
              textAlign: TextAlign.left,
            ),
            new Expanded(
                child: new Slider(
              onChanged: (double value) {
                setState(() {
                  currentValue = value;
                });
              },
              divisions: null,
              min: -4,
              max: 4,
              label: '$currentValue',
              value: currentValue,
            )),
            new Text(
              '+4',
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );

    final sintomasComorb = Container(
        child: Column(
      children: <Widget>[
        TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            labelText: 'Sintomas Comorbitos',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ],
    ));

    final outrasInfo = Container(
        child: Column(
      children: <Widget>[
        TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            labelText: 'Outras Informações',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
      ],
    ));

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Indormações Adicionais"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            new Text("Data"),
            data,
            SizedBox(height: 25.0),
            new Text("Atibua uma Nota para o seu Humor"),
            notaHumor,
            SizedBox(height: 25.0),
            medicamentos,
            SizedBox(height: 25.0),
            horasDormidas,
            SizedBox(height: 25.0),
            menstrual,
            SizedBox(height: 25.0),
            eventos,
            SizedBox(height: 25.0),
            new Text("impacto do evento de vida"),
            impacto,
            SizedBox(height: 25.0),
            sintomasComorb,
            SizedBox(height: 25.0),
            outrasInfo,
            SizedBox(height: 48.0),
            sentBtt,
          ],
        ),
      ),
    );
  }
}
