import 'package:afetivo/pages/afetivograma.dart';
import 'package:afetivo/pages/cadastroPage.dart';
import 'package:afetivo/pages/configuracoes.dart';
import 'package:afetivo/pages/ajuda.dart';
import 'package:afetivo/pages/createUser.dart';
import 'package:afetivo/pages/forgotPage.dart';
import 'package:afetivo/pages/loadingScreen.dart';
import 'package:afetivo/pages/loginPage.dart';
import 'package:afetivo/services/NavigationService.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'pages/dashboard.dart';

void main() => runApp(AppMain());

class AppMain extends StatefulWidget {
  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  FirebaseAnalytics analytics;
  NavigationService navigationService;
  LoginStore loginStore;
  HumorStore humorStore;

  @override
  void initState() {
    analytics = FirebaseAnalytics();
    navigationService = NavigationService();
    loginStore = LoginStore();
    humorStore = HumorStore(loginStore: loginStore);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final root = MultiProvider(
        providers: [
          Provider<LoginStore>(
            create: (_) => loginStore,
          ),
          Provider<HumorStore>(
            create: (_) => humorStore,
          ),
        ],
        child: MaterialApp(
            navigatorKey: navigationService.navigatorKey,
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR')
            ],
            title: 'Afetivo',
            debugShowCheckedModeBanner: false,
            theme: new ThemeData(
              primarySwatch: Colors.green,
            ),
            home: LoadingScreen(),
            routes: <String, WidgetBuilder>{
              LoadingScreen.tag: (context) => LoadingScreen(),
              "/config": (context) => Configuracoes("Configurações"),
              "/help": (context) => Ajuda("Ajuda"),
              DashboardScreen.tag: (context) =>
                  DashboardScreen(title: 'Afetivo'),
              FogotPage.tag: (context) => FogotPage(),
              Afetivograma.tag: (context) => Afetivograma(),
              LoginPage.tag: (context) => LoginPage(),
              CadastroPage.tag: (context) => CadastroPage(),
              CreateUser.tag: (context) => CreateUser(),
            }));
    autorun((_) {
      switch (loginStore.loginState) {
        case LoginState.LoggedIn:
          navigationService.forceNamedRoute(DashboardScreen.tag);
          break;
        case LoginState.NoProfile:
          navigationService.forceNamedRoute(CadastroPage.tag);
          break;
        case LoginState.LoggedOut:
          navigationService.forceNamedRoute(LoginPage.tag);
          break;
        default:
          navigationService.forceNamedRoute(LoadingScreen.tag);
          break;
      }
    });
    return root;
  }
}
