import 'package:afetivo/pages/afetivograma.dart';
import 'package:afetivo/pages/cadastroPage.dart';
import 'package:afetivo/pages/configuracoes.dart';
import 'package:afetivo/pages/ajuda.dart';
import 'package:afetivo/pages/forgotPage.dart';
import 'package:afetivo/pages/home.dart';
import 'package:afetivo/pages/loginPage.dart';
import 'package:flutter/material.dart';

import 'pages/adicionalInfo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Afetivo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.green,
          //canvasColor: Colors.white,
          //primaryColor: const Color(0xFF02BB9F),
          //primaryColorDark: const Color(0xFF167F67),
          //accentColor: const Color(0xFFFFAD32),
        ),
        home: LoginPage(),
        //new DashboardScreen(title: 'Afetivo'),
        routes: <String, WidgetBuilder>{
          "/a": (BuildContext context) => configuracoes("Configurações"),
          "/b": (BuildContext context) => ajuda("Ajuda"),
          LoginPage.tag: (context) => LoginPage(),
          DashboardScreen.tag: (context) => DashboardScreen(title: 'Afetivo'),
          FogotPage.tag: (context) => FogotPage(),
          AddicionalInfo.tag: (context) => AddicionalInfo(),
          Afetivograma.tag: (context) => Afetivograma("Afetivograma"),
          CadastroPage.tag: (context) => CadastroPage(),
        });
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
            new UserAccountsDrawerHeader(
              accountName: new Text("Dalton Costa"),
              accountEmail: new Text("dalton.bc96@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.green[300],
                child: new Text("D"),
              ),
            ),
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
              title: new Text("Fechar"),
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
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
