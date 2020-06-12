import 'package:afetivo/pages/afetivograma.dart';
import 'package:afetivo/pages/cadastroPage.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:afetivo/widgets/humorselector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = 'DashboardScreen';
  DashboardScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginStore loginStore = LoginStore();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.title,
          style: new TextStyle(color: const Color(0xFFFFFFFF)),
        ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            Observer(
                builder: (context) => loginStore.userProfile != null
                    ? UserAccountsDrawerHeader(
                        accountName: new Text(loginStore.userProfile.fullName),
                        accountEmail: new Text(loginStore.userProfile.email),
                        currentAccountPicture: new CircleAvatar(
                          backgroundColor: Colors.green[300],
                          child: new Text("D"),
                        ),
                      )
                    : SizedBox.shrink()),
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
