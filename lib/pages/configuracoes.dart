import 'package:flutter/material.dart';

class Configuracoes extends StatelessWidget {
  final String title;

  Configuracoes(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Text("Aqui terá a configurações: notificações e conta"),
      ),
    );
  }
}
