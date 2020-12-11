import 'package:flutter_html/style.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  static final String tag = 'tag-page-tutorial';

  @override
  _State createState() => _State();
}

class _State extends State<TutorialPage> implements YouTubePlayerListener {
  final loginStore = LoginStore();
  FlutterYoutubeViewController _ytController;

  @override
  Widget build(BuildContext context) {
    final first = loginStore.userProfile.firstLogin ?? true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Apresentação"),
        actions: [
          if (first)
            MaterialButton(
                onPressed: () {
                  loginStore.userProfile.firstLogin = false;
                  loginStore.register(loginStore.userProfile);
                },
                child: Text("Prosseguir",
                    style: TextStyle(color: Colors.white, fontSize: 20.0))),
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 20.0, left: 8.0),
                  child: Text(
                    'Assita o vídeo de apresentação!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ))),
          Container(
              margin: const EdgeInsets.only(top: 80, bottom: 80),
              child: FlutterYoutubeView(
                listener: this,
                onViewCreated: (controller) => this._ytController = controller,
                params: YoutubeParam(
                    videoId: 'gzsYp1rDo2Y',
                    autoPlay: true,
                    showUI: true,
                    showFullScreen: false),
              )),
        ],
      ),
    );
  }

  @override
  void onCurrentSecond(double second) {
    // TODO: implement onCurrentSecond
  }

  @override
  void onError(String error) {
    // TODO: implement onError
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  void onStateChange(String state) {
    // TODO: implement onStateChange
  }

  @override
  void onVideoDuration(double duration) {
    // TODO: implement onVideoDuration
  }
}
