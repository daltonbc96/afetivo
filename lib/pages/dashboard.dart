import 'package:afetivo/pages/afetivograma.dart';
import 'package:afetivo/pages/cadastroPage.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:afetivo/widgets/humorselector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DashboardScreen extends StatelessWidget {
  static String tag = 'DashboardScreen';

  final String title = 'Afetivo';

  @override
  Widget build(BuildContext context) {
    LoginStore loginStore = LoginStore();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          title,
          style: new TextStyle(color: const Color(0xFFFFFFFF)),
        ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            Observer(builder: (context) {
              final userProfile = loginStore.userProfile;
              return loginStore.userProfile != null
                  ? UserAccountsDrawerHeader(
                      accountName: new Text(userProfile.fullName),
                      accountEmail: new Text(userProfile.email),
                      currentAccountPicture: new CircleAvatar(
                        backgroundColor: Colors.green[300],
                        child: new Text((userProfile.nome[0] ?? '') +
                            (userProfile.sobrenome[0] ?? '')),
                      ),
                    )
                  : SizedBox.shrink();
            }),
            new ListTile(
              title: new Text("Configurações"),
              trailing: new Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pushNamed(CadastroPage.tag);
              },
            ),
            new ListTile(
              title: new Text("Ajuda"),
              trailing: new Icon(Icons.help_outline),
              onTap: () {
                Navigator.of(context).pushNamed("/help");
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Sair"),
              trailing: new Icon(Icons.close),
              onTap: loginStore.logout,
            ),
          ],
        ),
      ),
      body: Afetivograma(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context) => HumorSelector());
        },
      ),
    );
  }
}

//References
//https://github.com/DeveloperLibs/flutter_bottom_bar_navigation
