import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Afetivograma extends StatelessWidget {
  Afetivograma(this.listType);
  final String listType;
  static String tag = 'afetivograma-page';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              listType,
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
