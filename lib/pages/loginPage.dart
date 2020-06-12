import 'package:validators/validators.dart' as validator;
import 'package:afetivo/stores/LoginStore.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'createUser.dart';
import 'forgotPage.dart';
import '../widgets/MyTextFormField.dart';

class LoginPage extends StatefulWidget {
  static final tag = 'login_page';
  @override
  _State createState() => _State();
}

enum _LoginStatus { Idle, Wait, Error }

class _State extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  _LoginStatus _loginStatus = _LoginStatus.Idle;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    LoginStore loginStore = LoginStore();

    final emailField = MyTextFormField(
      labelText: 'E-mail',
      isEmail: true,
      validator: (value) => validator.isEmail(value) ? null : "E-Mail invalido",
      onSaved: (value) {
        this.email = value;
      },
    );

    final passwordField = MyTextFormField(
      labelText: 'Senha',
      isPassword: true,
      validator: (value) => validator.isNull(value) ? "Senha em branco" : null,
      onSaved: (value) {
        this.password = value;
      },
    );

    final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: new MaterialButton(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0)),
          height: 40.0,
          minWidth: 70.0,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: new Text("ENTRAR", style: TextStyle(fontSize: 16.0)),
          onPressed: () async {
            if (!_formKey.currentState.validate()) return;
            _formKey.currentState.save();
            try {
              setState(() {
                _loginStatus = _LoginStatus.Wait;
              });
              await loginStore.login(this.email, this.password);
            } on LoginError catch (_) {
              setState(() {
                _loginStatus = _LoginStatus.Error;
              });
            }
          },
          splashColor: Colors.redAccent,
        ));

    final errorMessage = Container(child: Builder(builder: (context) {
      switch (_loginStatus) {
        case _LoginStatus.Error:
          return Text("Usuario ou senha invalido",
              style: TextStyle(color: Colors.redAccent));
        default:
          return Text("");
      }
    }));

    final cadastro = FlatButton(
        child: Text(
          'CRIAR CONTA',
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(CreateUser.tag);
        });

    final forgotLabel = FlatButton(
      child: Text(
        'ESQUECI MINHA SENHA',
        style: TextStyle(color: Colors.black54, fontSize: 15),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(FogotPage.tag);
      },
    );

    return LoadingOverlay(
      isLoading: (_loginStatus == _LoginStatus.Wait),
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("Login"),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                emailField,
                passwordField,
                errorMessage,
                loginButton,
                forgotLabel,
                cadastro,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
