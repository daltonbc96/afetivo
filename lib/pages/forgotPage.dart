import 'package:afetivo/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FogotPage extends StatefulWidget {
  static String tag = 'tag-pageFoget';
  final fireauth = FirebaseAuth.instance;
  @override
  _State createState() => _State();
}

//TODO: Implement password reminder
class _State extends State<FogotPage> {
  TextEditingController emailFieldController;

  @override
  void initState() {
    super.initState();
    emailFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      controller: emailFieldController,
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
          onPressed: () async {
            await widget.fireauth
                .sendPasswordResetEmail(email: emailFieldController.text);
            Navigator.of(context).pop();
          },
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
