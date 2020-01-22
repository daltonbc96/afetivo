import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddicionalInfo extends StatefulWidget {
  static String tag = 'tag-pageAddInfo';

  final RegistroHumor humor;

  AddicionalInfo({Key key, this.humor}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AddicionalInfo> {
  RegistroHumor humor;
  double mCurrentValue = 50.0;
  double currentValue = 0.0;
  @override
  void initState() {
    super.initState();
    humor = this.widget.humor ?? RegistroHumor();
  }

  @override
  void dispose() {
    super.dispose();
    humor.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var humorStore = Provider.of<HumorStore>(context);
    final data = Observer(
        builder: (context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DateTimeField(
                      format: DateFormat(DateFormat.YEAR_MONTH_DAY),
                      onChanged: (value) => humor.data = value,
                      initialValue: humor.data ?? DateTime.now(),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate:
                                DateTime.now().subtract(Duration(days: 3)),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime.now());
                      },
                    ),
                  ],
                ),
              ),
            ));

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
          onPressed: () async {
            await humorStore.addHumor(humor);
            Navigator.of(context).pop();
          },
          splashColor: Colors.redAccent,
        ));

    final notaHumor = SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.black,
          activeTickMarkColor: Colors.white,
          inactiveTickMarkColor: Colors.white,
          inactiveTrackColor: Colors.black,
          valueIndicatorColor: Colors.green,
          thumbColor: Colors.green,
          overlayColor: Colors.amber,
        ),
        child: new Container(
          margin: const EdgeInsets.all(10.0),
          child: Observer(
            builder: (context) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: new Slider(
                  onChanged: (double value) {
                    humor.nota = value.round();
                  },
                  divisions: null,
                  min: 0,
                  max: 100,
                  label: humor.nota.toString(),
                  value: (humor.nota ?? 50).toDouble(),
                )),
                new Text(
                  (humor.nota ?? 'NA').toString(),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ));

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
        child: Observer(
      builder: (context) => TextFormField(
        keyboardType: TextInputType.number,
        initialValue: (humor.horasDormidas ?? '').toString(),
        onChanged: (value) => humor.horasDormidas = int.parse(value),
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Horas Dormidas',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    ));

    final menstrual = Container(
        child: Row(children: <Widget>[
      Text("Você está no Período Menstrual?"),
      Observer(
          builder: (context) => Checkbox(
                onChanged: (value) => humor.periodoMenstrual = value,
                value: humor.periodoMenstrual ?? false,
              ))
    ]));

    final disforica = Container(
        child: Row(children: <Widget>[
      Text("Sua Mania é disforica?"),
      Observer(
          builder: (context) => Checkbox(
                onChanged: (value) => humor.disforico = value,
                value: humor.disforico,
              ))
    ]));

    final eventos = Observer(
      builder: (context) => TextFormField(
        initialValue: humor.eventoDeVida,
        onChanged: (value) => humor.eventoDeVida = value,
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Eventos de Vida',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );

    final impacto = Column(children: [
      Text("impacto do evento de vida"),
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.black,
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
                  child: Observer(
                      builder: (context) => Slider(
                            onChanged: (double value) =>
                                humor.impactoEvento = value,
                            divisions: 16,
                            min: -4,
                            max: 4,
                            label: humor.impactoEvento.toString(),
                            value: humor.impactoEvento,
                          ))),
              new Text(
                '+4',
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      )
    ]);

    final sintomasComorb = Observer(
      builder: (context) => TextFormField(
        autofocus: false,
        initialValue: humor.sintomas,
        onChanged: (value) => humor.sintomas = value,
        decoration: InputDecoration(
          labelText: 'Sintomas Comorbitos',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );

    final outrasInfo = Observer(
      builder: (context) => TextFormField(
        autofocus: false,
        initialValue: humor.otherInfo,
        onChanged: (value) => humor.otherInfo = value,
        decoration: InputDecoration(
          labelText: 'Outras Informações',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: new AppBar(
          title: Column(children: [
            Text("Indormações Adicionais"),
            Text(describeTipoHumor(humor.tipo))
          ]),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Observer(
            builder: (context) => ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: 24.0),
                if (tipoHumorManiaco(humor.tipo)) disforica,
                SizedBox(height: 24.0),
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
                SizedBox(height: 12.5),
                if (humor.eventoDeVida != null) impacto,
                SizedBox(height: 12.5),
                sintomasComorb,
                SizedBox(height: 25.0),
                outrasInfo,
                SizedBox(height: 48.0),
                sentBtt,
              ],
            ),
          ),
        ));
  }
}
