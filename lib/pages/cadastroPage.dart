import 'package:afetivo/main.dart';
import 'package:afetivo/models/Medicamento.dart';
import 'package:afetivo/models/User.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CadastroPage extends StatefulWidget {
  static String tag = 'tag-page-cadastro';
  final UserProfile userProfile;

  CadastroPage({Key key, this.userProfile}) : super(key: key);

  @override
  _State createState() => _State();
}

enum _CadastroStatus { Idle, Wait, Error }

//TODO: Implement form validation
class _State extends State<CadastroPage> {
  TextEditingController _diagnosticoFieldController;
  TextEditingController _medNameFieldController;
  TextEditingController _medDoseFieldController;
  TextEditingController _passwordFieldController;
  UserProfile _userProfile;
  _CadastroStatus _cadastroStatus;
  RegisterError _error;

  @override
  void initState() {
    super.initState();
    _userProfile = widget.userProfile ?? UserProfile();
    _cadastroStatus = _CadastroStatus.Idle;
    _diagnosticoFieldController = TextEditingController();
    _passwordFieldController = TextEditingController();
    _medNameFieldController = TextEditingController();
    _medDoseFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _diagnosticoFieldController.dispose();
    _passwordFieldController.dispose();
    _medNameFieldController.dispose();
    _medDoseFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginStore loginStore = Provider.of<LoginStore>(context);
    final email = Observer(
        builder: (context) => TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              onChanged: (value) => _userProfile.email = value,
              decoration: InputDecoration(
                labelText: 'E-mail',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ));

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _passwordFieldController,
      decoration: InputDecoration(
        labelText: 'Senha',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final primeiroNome = Observer(
        builder: (context) => TextFormField(
              autofocus: false,
              initialValue: _userProfile.nome,
              onChanged: (value) => _userProfile.nome = value,
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
              initialValue: _userProfile.sobrenome,
              onChanged: (value) => _userProfile.sobrenome = value,
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
              value: _userProfile.sexo,
              onChanged: (value) => _userProfile.sexo = value,
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
                      onChanged: (value) => _userProfile.nascimento = value,
                      initialValue: _userProfile.nascimento,
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
            controller: _diagnosticoFieldController,
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
              _userProfile.addDiagnostico(_diagnosticoFieldController.text);
              _diagnosticoFieldController.text = '';
            },
          ),
        ],
      ),
    );

    final diagnosticosList = Observer(
        builder: (context) => Column(
            children: _userProfile.diagnosticos
                .map(
                  (item) => Observer(
                    builder: (context) => ListTile(
                        title: Text(
                          item,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _userProfile.deleteDiagnostico(item),
                        )),
                  ),
                )
                .toList()));

    final medicamentoAdder = Container(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: TextField(
                controller: _medNameFieldController,
                decoration: InputDecoration(
                  labelText: 'Medicamento:',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: TextField(
                controller: _medDoseFieldController,
                decoration: InputDecoration(
                  labelText: 'Dose:',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              )),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final medicamento = Medicamento(
                  nome: _medNameFieldController.text,
                  dose: _medDoseFieldController.text);
              _userProfile.addMedicamento(medicamento);
              _medNameFieldController.text = '';
              _medDoseFieldController.text = '';
            },
          ),
        ],
      ),
    );

    final medicamentoList = Observer(
        builder: (context) => Column(
            children: _userProfile.medicamentos
                .map(
                  (item) => Observer(
                    builder: (context) => ListTile(
                      title: Text(
                        "${item.nome}, ${item.dose}",
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _userProfile.deleteMedicamento(item),
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
        child: Builder(
            builder: (context) => Text(
                _cadastroStatus == _CadastroStatus.Wait
                    ? "CADASTRANDO..."
                    : "CADASTRAR",
                style: TextStyle(fontSize: 16.0))),
        onPressed: () async {
          try {
            setState(() {
              _cadastroStatus = _CadastroStatus.Wait;
            });
            await loginStore.register(
                _userProfile, _passwordFieldController.text);
            setState(() {
              _cadastroStatus = _CadastroStatus.Idle;
            });
            Navigator.of(context)
                .pushNamedAndRemoveUntil(DashboardScreen.tag, (_) => false);
          } on RegisterError catch (e) {
            setState(() {
              _cadastroStatus = _CadastroStatus.Error;
              _error = e;
            });
          }
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
              SizedBox(height: 25.0),
              medicamentoAdder,
              medicamentoList,
              SizedBox(height: 25.0),
              sentBtt,
            ],
          ),
        ),
      ),
    );
  }
}
