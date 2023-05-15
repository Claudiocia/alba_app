import 'package:alba_app/models/noticia_model.dart';
import 'package:alba_app/pages/pesq_news_page.dart';
import 'package:alba_app/splashscreen.dart';
import 'package:alba_app/utils/news_pesq_api.dart';
import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PlacePesqNoticiaWidget extends StatefulWidget {
  int editoria;
  DateTime inicio;
  DateTime fim;
  String palavra;
  PlacePesqNoticiaWidget({this.palavra, this.inicio, this.fim, this.editoria});

  @override
  PlacePesqNoticiaWidgetState createState() => PlacePesqNoticiaWidgetState();
}

class PlacePesqNoticiaWidgetState extends State<PlacePesqNoticiaWidget> {
  NewsPesqApi pesqnewsApi = NewsPesqApi();
  NoticiaModel noti;
  List<NoticiaModel> listNotis = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    pesqnewsApi.loadPesqNews(palavra: widget.palavra, dataInicio: widget.inicio, dataFim: widget.fim, editId: widget.editoria).then((value){
      setState(() {
        if(value != null){
          listNotis = value;
          isLoading = false;
        }else{
          isLoading = false;
        }
      });
    });
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
          title: Image.asset(
            "assets/images/marca_mobi.png",
            width: 100.0,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: "Pesquisar",
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => PlacePesqNewsWidget()));
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: "Recarregar",
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SplashScreenPage()));
              },
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: listaNoticias(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  listaNoticias() {
    if(isLoading){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/marca_alba_s.jpg",
              width: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Carregando...",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }else if(listNotis.length > 0){
      return ListView.separated(
          padding: EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
          separatorBuilder: (context, index) => Divider(color: Colors.black54),
          itemCount: listNotis.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                listNotis[index].dataNoticia,
                style: TextStyle(fontFamily: 'Dosis', fontSize: 16, color: Colors.black87),
              ),
              subtitle: Text(
                listNotis[index].titleNoticia,
                style: TextStyle(
                  fontFamily: 'Dosis',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 2,
              ),
              leading: Image.network(
                listNotis[index].fotoNoticia,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Qual o seu desejo?", style: TextStyle(fontFamily: 'Dosis'),),
                      content: Text(
                        listNotis[index].titleNoticia,
                        style: TextStyle(fontFamily: 'Dosis', fontWeight: FontWeight.bold),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: (){
                            Uri urlNew = Uri.parse(listNotis[index].linkNoticia);
                            _launchURL(urlNew);

                            Navigator.of(context).pop(true);
                          },
                          child: Text("Ler a íntegra da noticia!", style: TextStyle(fontFamily: 'Dosis'),),
                        ),
                        TextButton(
                          onPressed: (){

                            _shareLink(listNotis[index].linkNoticia, listNotis[index].titleNoticia);
                            Navigator.of(context).pop(true);
                          },
                          child: Text("Compartilhar", style: TextStyle(fontFamily: 'Dosis'),),
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.of(context).pop(true);
                            },

                            child: Text('FECHAR', style: TextStyle(fontFamily: 'Dosis'),))
                      ],
                    ));
              },
            );
          });
    } else{
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/marca_alba_s.jpg",
              width: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Busca sem resultados!",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  _launchURL(Uri urlNew) async {
    //print("a url é: "+ urlNew);
    if (await canLaunchUrl(urlNew)) {
      await launchUrl(urlNew, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não consegue acessar o endereço $urlNew';
    }
  }

  _shareLink(String texto, String title) async {
    String msg = "*Compart. via Aplicativo ALBA";
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    await await flutterShareMe.shareToSystem(msg: title+"\n"+texto+"\n"+msg);
  }

}
