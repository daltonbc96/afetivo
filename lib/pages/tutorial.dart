import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  static String tag = 'tag-page-tutorial';

  @override
  _State createState() => _State();
}

class _State extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Tutorial"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            new Text(
              "Preencha os campos com seus dados para realizar seu cadastro",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
