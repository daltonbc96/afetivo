import 'package:afetivo/stores/LoginStore.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  static final String tag = 'tag-page-tutorial';

  @override
  _State createState() => _State();
}

class _State extends State<TutorialPage> {
  final loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorial"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text(
              "Preencha os campos com seus dados para realizar seu cadastro",
              style: TextStyle(fontSize: 20),
            ),
            MaterialButton(
              onPressed: () {
                loginStore.userProfile.firstLogin = false;
                loginStore.register(loginStore.userProfile);
              },
              child: Text("Prosseguir"),
            )
          ],
        ),
      ),
    );
  }
}
