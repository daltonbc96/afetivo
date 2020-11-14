import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddicionalInfo extends StatefulWidget {
  static String tag = 'tag-pageAddInfo';

  final RegistroHumor humor;

  AddicionalInfo({Key key, @required this.humor}) : super(key: key);

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
    this.humor = RegistroHumor.from(this.widget.humor);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final humorStore = HumorStore();

    final data = Observer(
        builder: (context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DateTimeField(
                      format: DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_BR'),
                      onChanged: (value) => humor.data = value,
                      initialValue: humor.data ?? DateTime.now(),
                      onShowPicker: (context, currentValue) => showDatePicker(
                          context: context,
                          firstDate: DateTime.now().subtract(Duration(days: 3)),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime.now()),
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
          child: new Text("Registrar", style: TextStyle(fontSize: 20.0)),
          onPressed: () {
            humorStore.editHumor(humor);
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
          margin: const EdgeInsets.all(16.0),
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
        child: Observer(
            builder: (context) => Column(
                children: humor.medicamentos
                    .map((item) => Observer(
                          builder: (context) => Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    "${item.medicamento.nome}, ${item.medicamento.dose}",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: (item.numeroComprimidos ?? '')
                                        .toString(),
                                    onChanged: (value) => item
                                        .numeroComprimidos = int.parse(value),
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      labelText: 'Qt. Comprimidos:',
                                      isDense: true, // Added this
                                      contentPadding: EdgeInsets.all(8),

                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ))
                    .toList())));

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
      Text(
        "Você está no seu ciclo \nmenstrual?",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Observer(
          builder: (context) => Checkbox(
                onChanged: (value) => humor.periodoMenstrual = value,
                value: humor.periodoMenstrual ?? false,
              ))
    ]));

    final disforica = Container(
        child: Row(children: <Widget>[
      Text(
        "Sua Mania é disfórica?",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      IconButton(
        icon: Icon(Icons.help),
        iconSize: 20,
        color: Colors.black38,
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctxt) => new AlertDialog(
                    title: Text(
                      "Mania disfórica",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    insetPadding: EdgeInsets.symmetric(),
                    content: Container(
                        width: 400,
                        height: 300,
                        child: SingleChildScrollView(
                          child: Text(
                            'Se você estiver experienciando sintomas de mania/hipomania associados com raiva, irritabilidade ou ansiedade e esse estado energizado é desagradável ou disfórico, por favor, marque a opção "mania disfórica".',
                            style: TextStyle(fontSize: 18, height: 1.5),
                            textAlign: TextAlign.justify,
                          ),
                        )),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
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
                  ));
        },
      ),
      Observer(
          builder: (context) => Checkbox(
                onChanged: (value) => humor.disforico = value,
                value: humor.disforico,
              ))
    ]));

    final eventos = Observer(
      builder: (context) => TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        initialValue: humor.eventoDeVida,
        onChanged: (value) => humor.eventoDeVida = value,
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Eventos de vida',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );

    final impacto = Column(children: [
      Text(
        "Impacto do evento de vida",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Image.asset("assets/images/notaEvento.jpg", width: 500, height: 80),
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
          margin: const EdgeInsets.all(16.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                '-4',
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
                        )),
              ),
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
        keyboardType: TextInputType.multiline,
        maxLines: null, //Number_of_lines(int),)
        autofocus: false,
        initialValue: humor.sintomas,
        onChanged: (value) => humor.sintomas = value,
        decoration: InputDecoration(
          labelText: 'Sintomas comorbitos',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );

    final outrasInfo = Observer(
      builder: (context) => TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null, //Number_of_lines(int),)
        textAlignVertical: TextAlignVertical.center,
        autofocus: false,
        initialValue: humor.otherInfo,
        onChanged: (value) => humor.otherInfo = value,
        decoration: InputDecoration(
          labelText: 'Outras informações',
          contentPadding: EdgeInsets.all(16),
          //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            SizedBox(
                width: 70,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green)),
                  child: const Text('Ajuda'),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/help");
                  },
                )),
          ],
          title: Column(children: [
            Text("Informações Adicionais", textAlign: TextAlign.center),
            Text(describeTipoHumor(humor.tipo), textAlign: TextAlign.center)
          ]),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Observer(
            builder: (context) => ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                SizedBox(height: 10.0),
                if (tipoHumorManiaco(humor.tipo)) disforica,
                SizedBox(height: 25.0),
                new Text(
                  "Data",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                data,
                SizedBox(height: 50.0),
                new Text(
                  'Avalie seu humor de forma  geral',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                new Text(
                  "Escolha um número de 0 a 100, baseado na escala de humor demonstrada abaixo:",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Image.asset("assets/images/nota_humor.jpg",
                    width: 100, height: 110),
                notaHumor,
                SizedBox(height: 35.0),
                menstrual,
                SizedBox(height: 25.0),
                Text(
                  "Medicamentos",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                medicamentos,
                SizedBox(height: 35.0),
                horasDormidas,
                SizedBox(height: 35.0),
                eventos,
                SizedBox(height: 20),
                if (humor.eventoDeVida != null) impacto,
                SizedBox(height: 20),
                sintomasComorb,
                SizedBox(height: 35),
                outrasInfo,
                SizedBox(height: 35),
                sentBtt,
              ],
            ),
          ),
        ));
  }
}
