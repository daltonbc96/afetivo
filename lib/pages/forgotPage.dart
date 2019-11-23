import 'package:afetivo/pages/loginPage.dart';
import 'package:flutter/material.dart';

class FogotPage extends StatefulWidget {
  static String tag = 'tag-pageFoget';
  @override
  _State createState() => _State();
}

class _State extends State<FogotPage> {
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
          child: new Text("RECUPERAR SENHA", style: TextStyle(fontSize: 16.0)),
          onPressed: () => {Navigator.of(context).pushNamed(LoginPage.tag)},
          splashColor: Colors.redAccent,
        ));

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Recuperar Senha"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text("Digite o e-mail cadastrado"),
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            sentBtt
          ],
        ),
      ),
    );
  }
}
