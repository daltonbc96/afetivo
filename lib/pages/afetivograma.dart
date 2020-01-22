import 'package:afetivo/stores/HumorStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:afetivo/models/Humor.dart';

class Afetivograma extends StatelessWidget {
  static String tag = 'afetivograma-page';

  @override
  Widget build(BuildContext context) {
    final humorStore = Provider.of<HumorStore>(context);

    return new Scaffold(
        body: new Center(
            child: Observer(
                builder: (_) => ListView.builder(
                    itemCount: humorStore.humorList.length,
                    itemBuilder: (context, index) {
                      final humor = humorStore.humorList[index];
                      return _HumorCard(humor);
                    }))));
  }
}

typedef Future<void> Callback(BuildContext context, RegistroHumor humor);

class _MenuOption {
  final String title;
  final Callback callback;

  _MenuOption(this.title, this.callback);
}

class _HumorCard extends StatefulWidget {
  final RegistroHumor humor;
  _HumorCard(this.humor);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<_HumorCard> {
  bool isExpanded;

  @override
  void initState() {
    this.isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final humorStore = Provider.of<HumorStore>(context);
    final humor = this.widget.humor;
    final _menuItems = [
      _MenuOption("Editar", (context, humor) async {
        print("Vc clicou em editar");
      }),
      _MenuOption("Remover", (context, humor) async {
        await humorStore.deleteHumor(humor);
      })
    ];
    return Card(
        child: ExpansionPanelList(
            expansionCallback: (_, isExpanded) => setState(() {
                  this.isExpanded = !isExpanded;
                }),
            children: [
          ExpansionPanel(
              headerBuilder: (context, isExpanded) => ListTile(
                    title: Text(describeTipoHumor(humor.tipo)),
                    subtitle: Text(DateFormat.yMd().format(humor.data)),
                  ),
              body: ListTile(
                  trailing: PopupMenuButton<_MenuOption>(
                initialValue: _menuItems[0],
                itemBuilder: (context) => _menuItems
                    .map((item) =>
                        PopupMenuItem(value: item, child: Text(item.title)))
                    .toList(),
                onSelected: (choice) => choice.callback(context, humor),
              )),
              isExpanded: isExpanded)
        ]));
  }
}
