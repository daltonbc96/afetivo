import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  static final tag = "/loading";
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: CircularProgressIndicator()));
}
