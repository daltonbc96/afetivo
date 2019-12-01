import 'package:flutter/material.dart';

class Ajuda extends StatelessWidget {
  final String title;

  Ajuda(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Text("Aqui terá conteúdo de ajuda! :)"),
      ),
    );
  }
}
