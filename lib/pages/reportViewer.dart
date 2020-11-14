import 'package:afetivo/pages/loadingScreen.dart';
import 'package:afetivo/stores/LoginStore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:afetivo/models/Humor.dart';
import 'package:afetivo/pages/pdfReport.dart';
import 'package:afetivo/stores/HumorStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ReportViewer extends StatelessWidget {
  static final tag = '/reportViewer';
  final _humorStore = HumorStore();
  final _loginStore = LoginStore();

  Future<String> genPDFFile(List<RegistroHumor> data) async {
    var pdf = PdfReport(data: data, user: _loginStore.userProfile);
    final dir = (await getTemporaryDirectory()).path;
    final path = '$dir/report.pdf';
    print(path);

    await pdf.saveToFile(path);
    //

    return path;
  }

  Widget build(BuildContext context) => Observer(
      builder: (context) => FutureBuilder<String>(
          future: genPDFFile(_humorStore.filteredHumors),
          builder: (context, path) => path.hasData
              ? PDFViewerScaffold(
                  appBar: AppBar(
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () => {},
                      )
                    ],
                  ),
                  path: path.data,
                )
              : LoadingScreen()));
}
