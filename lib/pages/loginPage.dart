import 'package:afetivo/pages/cadastroPage.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'createUser.dart';
import 'forgotPage.dart';

class LoginPage extends StatefulWidget {
  static final tag = 'login_page';
  @override
  _State createState() => _State();
}

enum _LoginStatus { Idle, Wait, Error }

class _State extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordControler;
  _LoginStatus _loginStatus;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordControler = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginStore loginStore = Provider.of<LoginStore>(context);
    final email = TextFormField(
      controller: _emailController,
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
      controller: _passwordControler,
      decoration: InputDecoration(
        labelText: 'Senha',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
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
            try {
              setState(() {
                _loginStatus = _LoginStatus.Wait;
              });
              await loginStore.login(
                  _emailController.text, _passwordControler.text);
              setState(() {
                _loginStatus = _LoginStatus.Idle;
              });
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
        case _LoginStatus.Wait:
          return Text("Validando Usuario...");
        default:
      }
      return Text("");
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

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Login"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            errorMessage,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel,
            cadastro,
          ],
        ),
      ),
    );
  }
}
