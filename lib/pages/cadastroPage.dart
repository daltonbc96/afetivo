import 'package:afetivo/main.dart';
import 'package:afetivo/models/User.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class CadastroPage extends StatefulWidget {
  static String tag = 'tag-page-cadastro';
  @override
  _State createState() => _State();
}

class _State extends State<CadastroPage> {
  final TextEditingController diagnosticoFieldController =
      TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();
  UserProfile userProfile = UserProfile();
  ReactionDisposer _disposePageChanger;

  @override
  void initState() {
    super.initState();
    _disposePageChanger = autorun((_) {
      if (LoginStore.instance.loginStatus == LoginStatus.LoggedIn)
        Navigator.of(context)
            .pushNamedAndRemoveUntil(DashboardScreen.tag, (_) => false);
    });
  }

  @override
  void dispose() {
    diagnosticoFieldController.dispose();
    _disposePageChanger();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginStore loginStore = Provider.of<LoginStore>(context);
    final email = Observer(
        builder: (context) => TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              onChanged: (value) => userProfile.email = value,
              decoration: InputDecoration(
                labelText: 'E-mail',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ));

    final password = Observer(
        builder: (context) => TextFormField(
              autofocus: false,
              obscureText: true,
              controller: passwordFieldController,
              decoration: InputDecoration(
                labelText: 'Senha',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ));

    final primeiroNome = Observer(
        builder: (context) => TextFormField(
              autofocus: false,
              onChanged: (value) => userProfile.nome = value,
              decoration: InputDecoration(
                labelText: 'Primeiro Nome',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ));

    final sobrenome = Observer(
        builder: (context) => TextFormField(
              autofocus: false,
              onChanged: (value) => userProfile.sobrenome = value,
              decoration: InputDecoration(
                labelText: 'Sobrenome',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ));

    final sexo = Observer(
        builder: (context) => Container(
                child: DropdownButton<Sexo>(
              hint: Text("Sexo"),
              isExpanded: true,
              value: userProfile.sexo,
              onChanged: (value) => userProfile.sexo = value,
              items: Sexo.values.map<DropdownMenuItem<Sexo>>((value) {
                return DropdownMenuItem<Sexo>(
                  value: value,
                  child: Text(describeSexo(value)),
                );
              }).toList(),
            )));

    final dataNascimento = Observer(
        builder: (context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DateTimeField(
                      format: DateFormat(DateFormat.YEAR_MONTH_DAY),
                      onChanged: (value) => userProfile.nascimento = value,
                      initialValue: userProfile.nascimento,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ],
                ),
              ),
            ));

    final diagnosticoAdder = Container(
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: diagnosticoFieldController,
            decoration: InputDecoration(
              labelText: 'Diagnosticos:',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          )),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              userProfile.addDiagnostico(diagnosticoFieldController.text);
              diagnosticoFieldController.text = '';
            },
          ),
        ],
      ),
    );

    final diagnosticosList = Observer(
        builder: (context) => Column(
            children: userProfile.diagnosticos
                .map(
                  (item) => Observer(
                    builder: (context) => ListTile(
                      title: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            item,
                            overflow: TextOverflow.ellipsis,
                          )),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                userProfile.deleteDiagnostico(item),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList()));

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
        child: Observer(
            builder: (context) => Text(
                loginStore.loginStatus == LoginStatus.LoginWait
                    ? "CADASTRANDO..."
                    : "CADASTRAR",
                style: TextStyle(fontSize: 16.0))),
        onPressed: () {
          loginStore.register(userProfile, passwordFieldController.text);
        },
        splashColor: Colors.redAccent,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Cadastro"),
      ),
      backgroundColor: Colors.white,
      body: Form(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(8),
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
              diagnosticoAdder,
              diagnosticosList,
              sentBtt,
            ],
          ),
        ),
      ),
    );
  }
}
