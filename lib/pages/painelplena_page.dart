import 'package:alba_app/pages/princ_page.dart';
import 'package:alba_app/pages/tvalba_page.dart';
import 'package:alba_app/presentation/custom_icons_icons.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';


class PlacePainelPlenaWidget extends StatefulWidget {
  const PlacePainelPlenaWidget({Key key, this.cookieManager}) : super(key: key);

  final CookieManager cookieManager;

  @override
  _PlacePainelPlenaWidgetState createState() => _PlacePainelPlenaWidgetState();
}

class _PlacePainelPlenaWidgetState extends State<PlacePainelPlenaWidget> {

  String titlePag;

  void onItemTapped(int index) {
    switch(index){
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceTVAlbaWidget()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PrincPage()));
        break;
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Dosis'),
      title: "ALBA APP",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF004a92),
          centerTitle: true,
          title: Image.asset("assets/images/marca_mobi.png",
            width: 100.0,),
        ),
        drawer: CustomDrawer(),
        body: WebView(
          initialUrl: 'https://sevweb.com.br/alba/painel/#/painel',
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (int progress){
            print('WebView está carregando (total: $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.notic),
              label: 'TV ALBA',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.dep_par),
              label: 'Sair',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.blueAccent, //amber[800],
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          onTap: onItemTapped,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

}