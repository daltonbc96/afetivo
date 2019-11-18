import 'package:flutter/material.dart';

class configuracoes extends StatelessWidget {
  final String title;

  configuracoes(this.title);

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
