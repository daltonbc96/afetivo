import 'package:afetivo/stores/PreferencesStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/styles.dart';

class OnboardingScreen extends StatefulWidget {
  static String tag = 'tag-page-OnboardingScreen';
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final _preferencesStore = PreferencesStore();

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0x99FFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF81C784),
                Color(0XFF66BB6A),
                Color(0XFF4CAF50),
                Color(0XFF43A047),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => _preferencesStore.setFirstRun(false),
                    child: Text(
                      'Pular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Center(
                    child: Container(
                  height: deviceHeight * 0.65,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.05,
                            vertical: deviceHeight * 0.025),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Icon(Icons.stacked_line_chart,
                                  size: deviceHeight * 0.2,
                                  color: Colors.white),
                            ),
                            SizedBox(height: deviceHeight * 0.025),
                            Text(
                              'Descubra uma nova forma de monitorar o seu humor',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: deviceHeight * 0.025),
                            Text(
                              'Monitore o seu humor diariamente e construa afetivogramas',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.05,
                            vertical: deviceHeight * 0.025),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Icon(Icons.rule_outlined,
                                  size: deviceHeight * 0.2,
                                  color: Colors.white),
                            ),
                            SizedBox(height: deviceHeight * 0.025),
                            Text(
                              'Descubra como o seu humor pode influenciar no seu dia a dia',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: deviceHeight * 0.025),
                            Text(
                              'Além do humor, você pode monitorar outras informações e hábitos da sua rotina',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.05,
                            vertical: deviceHeight * 0.025),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Icon(Icons.share,
                                  size: deviceHeight * 0.2,
                                  color: Colors.white),
                            ),
                            SizedBox(height: deviceHeight * 0.025),
                            Text(
                              'Compartilhe os seus registros',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: deviceHeight * 0.025),
                            Text(
                              'Você poderá compartilhar os seus registros com quem quiser',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage < _numPages
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Próxima',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: deviceHeight * 0.15,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => _preferencesStore.setFirstRun(false),
                child: Center(
                  //child: Padding(
                  //  padding: EdgeInsets.only(bottom: deviceHeight * 0.025),
                  child: Text(
                    'Vamos começar!',
                    style: TextStyle(
                      color: Color(0XFF4CAF50),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //),
                ),
              ),
            )
          : Text(''),
    );
  }
}

//https://github.com/MarcusNg/flutter_onboarding_ui
