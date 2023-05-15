import 'package:alba_app/helpers/deputado_helper.dart';
import 'package:alba_app/models/deputado_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDeputadoWidget extends StatefulWidget {
  PlaceDeputadoWidget();
  @override
  _PlaceDeputadoWidgetState createState() => _PlaceDeputadoWidgetState();
}

class _PlaceDeputadoWidgetState extends State<PlaceDeputadoWidget> {
  DeputadoHelper helperDep = DeputadoHelper();
  DeputadoModel dep = DeputadoModel();
  List<DeputadoModel> listDeps = List.empty();
  String pathDep = "https://www.al.ba.gov.br/deputados/deputado-estadual/";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helperDep.getAllDeps().then((list) {
      setState(() {
        listDeps = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listaDeputados(),
    );
  }

  listaDeputados() {
    return ListView.separated(
        padding: EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
        separatorBuilder: (context, index) => Divider(color: Colors.black54),
        itemCount: listDeps.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              "assets/images/" + listDeps[index].fotoDep,
            ),
            title: Text(
              "Dep. " + listDeps[index].nomeDep + " ("
                  + listDeps[index].partidoDep + ")",
              style: TextStyle(
                fontFamily: 'Dosis',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            subtitle: Text(
              "Edf. " +
                  (listDeps[index].gabineteDep).substring(6) +
                  "\n" +
                  listDeps[index].emailDep +
                  "\nTel: (71) " +
                  (listDeps[index].telefoneDep).substring(0, 9),
              style: TextStyle(
                fontFamily: 'Dosis',
              ),
            ),
            onTap: () {
              Uri urlNew = Uri.parse(pathDep + listDeps[index].linkDep);
              _launchURL(urlNew);
            },
          );
        });
  }

  _launchURL(Uri urlNew) async {
    //print("a url é: "+ urlNew);
    if (await canLaunchUrl(urlNew)) {
      await launchUrl(urlNew, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não consegue acessar o endereço $urlNew';
    }
  }
}