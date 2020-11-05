import 'package:flutter/material.dart';

class Ajuda extends StatefulWidget {
  final String title;

  Ajuda(this.title);
  @override
  _Ajuda createState() => _Ajuda();
}

class MyItem {
  MyItem({this.isExpanded: false, this.header, this.body});

  bool isExpanded;
  final String header;
  final String body;
}

class _Ajuda extends State<Ajuda> {
  List<MyItem> _items = <MyItem>[
    MyItem(
        header: "O que é o app Afetivo",
        body:
            'O app afetivo é um aplicativo tals kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk'),
    MyItem(header: "Header2", body: 'body2'),
    MyItem(header: "Header3", body: 'body3'),
    MyItem(header: "Header4", body: 'body4'),
  ];

  Widget _buildListPanel() {
    return Card(
        elevation: 10,
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _items[index].isExpanded = !_items[index].isExpanded;
            });
          },
          children: _items.map((MyItem item) {
            return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                      padding: EdgeInsets.all(10.0),
                      child: new Row(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(item.header,
                                    style: TextStyle(fontSize: 16))))
                      ]));
                },
                isExpanded: item.isExpanded,
                body: Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Text(item.body, style: TextStyle(fontSize: 14)),
                ));
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Ajuda'),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: _buildListPanel(),
            margin: new EdgeInsets.symmetric(horizontal: 2),
          ),
        ),
      ),
    );
  }
}
