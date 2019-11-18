import 'package:afetivo/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CadastroPage extends StatefulWidget {
  static String tag = 'tag-page-cadastro';
  @override
  _State createState() => _State();
}

class _State extends State<CadastroPage> {
  String sexos = 'Masculino';
  String _date = "Not set";
  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'E-mail',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Senha',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final primeiroNome = TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Primeiro Nome',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final sobrenome = TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Sobrenome',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final sexo = Container(
        child: DropdownButton<String>(
      hint: Text("Sexo"),
      isExpanded: true,
      value: sexos,
      onChanged: (String newValue) {
        setState(() {
          sexos = newValue;
        });
      },
      items: <String>['Masculino', 'Feminino', 'Outro/Não Informar']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));

    final dataNascimento = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
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

    final diagnosticos = TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Disagnósticos',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
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
          onPressed: () => {Navigator.of(context).pushNamed(LoginPage.tag)},
          splashColor: Colors.redAccent,
        ));

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Cadastro"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 25.0),
            new Text(
                "Preencha os campos com seus dados para realizar seu cadastro"),
            SizedBox(height: 25.0),
            email,
            SizedBox(height: 25.0),
            password,
            SizedBox(height: 25.0),
            primeiroNome,
            SizedBox(height: 25.0),
            sobrenome,
            SizedBox(height: 25.0),
            new Text("Sexo"),
            sexo,
            SizedBox(height: 25.0),
            new Text("Data de Nascimento"),
            dataNascimento,
            SizedBox(height: 25.0),
            diagnosticos,
            SizedBox(height: 48.0),
            sentBtt,
          ],
        ),
      ),
    );
  }
}
