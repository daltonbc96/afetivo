import 'package:afetivo/pages/afetivograma.dart';
import 'package:afetivo/pages/cadastroPage.dart';
import 'package:afetivo/pages/configuracoes.dart';
import 'package:afetivo/pages/ajuda.dart';
import 'package:afetivo/pages/forgotPage.dart';
import 'package:afetivo/pages/home.dart';
import 'package:afetivo/pages/loginPage.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'pages/adicionalInfo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
        create: (_) => LoginStore.instance,
        child: MaterialApp(
            title: 'Afetivo',
            debugShowCheckedModeBanner: false,
            theme: new ThemeData(
              primarySwatch: Colors.green,
            ),
            initialRoute: LoginPage.tag,
            routes: <String, WidgetBuilder>{
              "/a": (BuildContext context) => Configuracoes("Configurações"),
              "/b": (BuildContext context) => Ajuda("Ajuda"),
              DashboardScreen.tag: (context) =>
                  DashboardScreen(title: 'Afetivo'),
              FogotPage.tag: (context) => FogotPage(),
              Afetivograma.tag: (context) => Afetivograma("Afetivograma"),
              LoginPage.tag: (context) => LoginPage(),
              CadastroPage.tag: (context) => CadastroPage(),
            }));
  }
}

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
  ReactionDisposer _disposePageChanger;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _disposePageChanger = autorun((_) {
      if (LoginStore.instance.loginStatus == LoginStatus.LoggedOff)
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginPage.tag, (_) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _disposePageChanger();
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
    LoginStore loginStore = Provider.of<LoginStore>(context);
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
                Navigator.of(context).pushNamed("/a");
              },
            ),
            new ListTile(
              title: new Text("Ajuda"),
              trailing: new Icon(Icons.help_outline),
              onTap: () {
                Navigator.of(context).pushNamed("/b");
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
      body: new PageView(
        children: [
          new Home("Home"),
          new Afetivograma("Afetivograma screen"),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: const Color(0xFF167F67),
        ), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(
                  Icons.home,
                  color: const Color(0xFFFFFFFF),
                ),
                title: new Text(
                  "Home",
                  style: new TextStyle(
                    color: const Color(0xFFFFFFFF),
                  ),
                )),
            new BottomNavigationBarItem(
                icon: new Icon(
                  Icons.timeline,
                  color: const Color(0xFFFFFFFF),
                ),
                title: new Text(
                  "Afetivograma",
                  style: new TextStyle(
                    color: const Color(0xFFFFFFFF),
                  ),
                ))
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}

//References
//https://github.com/DeveloperLibs/flutter_bottom_bar_navigation
