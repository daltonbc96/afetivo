import 'package:afetivo/pages/cadastroPage.dart';

import 'package:afetivo/pages/ajuda.dart';
import 'package:afetivo/pages/createUser.dart';
import 'package:afetivo/pages/forgotPage.dart';
import 'package:afetivo/pages/loadingScreen.dart';
import 'package:afetivo/pages/loginPage.dart';
import 'package:afetivo/pages/reportViewer.dart';
import 'package:afetivo/pages/tutorial.dart';
import 'package:afetivo/services/NavigationService.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:afetivo/pages/onboarding_screen.dart';
import 'package:afetivo/stores/PreferencesStore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  PreferencesStore preferencesStore;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    analytics = FirebaseAnalytics();
    navigationService = NavigationService();
    loginStore = LoginStore();
    humorStore = HumorStore();
    preferencesStore = PreferencesStore();
    //initializeDateFormatting('pt_BR');

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, IOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload: $payload");
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text('Notification'),
              content: new Text('Minha notificao deu certo'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final root = MaterialApp(
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
          "/help": (context) => Ajuda("Ajuda"),
          DashboardScreen.tag: (context) => DashboardScreen(),
          FogotPage.tag: (context) => FogotPage(),
          LoginPage.tag: (context) => LoginPage(),
          CadastroPage.tag: (context) => CadastroPage(),
          TutorialPage.tag: (context) => TutorialPage(),
          CreateUser.tag: (context) => CreateUser(),
          OnboardingScreen.tag: (context) => OnboardingScreen(),
          ReportViewer.tag: (context) => ReportViewer(),
        });

    autorun((_) {
      if (preferencesStore.firstRun == null) return;
      if (preferencesStore.firstRun)
        navigationService.forceNamedRoute(OnboardingScreen.tag);
      else
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
          case LoginState.FirstLogin:
            navigationService.forceNamedRoute(TutorialPage.tag);
            break;
          default:
            navigationService.forceNamedRoute(LoadingScreen.tag);
            break;
        }
    });
    return root;
  }
}
