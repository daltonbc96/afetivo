import 'package:flutter/material.dart';

class ajuda extends StatelessWidget {
  final String title;

  ajuda(this.title);

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
