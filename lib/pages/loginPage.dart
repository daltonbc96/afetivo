import 'package:afetivo/main.dart';
import 'package:afetivo/pages/cadastroPage.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'forgotPage.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'tag-page';
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
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
    _emailController.dispose();
    _passwordControler.dispose();
    _disposePageChanger();
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
          onPressed: () {
            loginStore.login(_emailController.text, _passwordControler.text);
          },
          splashColor: Colors.redAccent,
        ));

    final errorMessage = Container(child: Observer(builder: (context) {
      switch (loginStore.loginStatus) {
        case LoginStatus.LoginError:
          return Text("Usuario ou senha invalido",
              style: TextStyle(color: Colors.redAccent));
        case LoginStatus.LoginWait:
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
          Navigator.of(context).pushNamed(CadastroPage.tag);
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
