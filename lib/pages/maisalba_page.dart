import 'package:alba_app/pages/comissoes_page.dart';
import 'package:alba_app/pages/painelplena_page.dart';
import 'package:alba_app/pages/partidos_page.dart';
import 'package:alba_app/pages/pauta_page.dart';
import 'package:alba_app/pages/radioalba_page.dart';
import 'package:alba_app/pages/tvalba_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'albacult_page.dart';
import 'mesadir_page.dart';

class PlaceMaisAlbaWidget extends StatefulWidget {
  PlaceMaisAlbaWidget();
  @override
  _PlaceMaisAlbaWidgetState createState() => _PlaceMaisAlbaWidgetState();
}

class _PlaceMaisAlbaWidgetState extends State<PlaceMaisAlbaWidget> {
  List<String> _filesNome = [
    'assets/images/ic_mesa_dir.png', //0
    'assets/images/ic_comissoes.png', //1
    'assets/images/ic_plenario.png', //2
    'assets/images/ic_pauta.png', //3
    'assets/images/ic_tvalba.png', //4
    'assets/images/ic_radio.png', //5
    'assets/images/ic_alba_cult.png', //6
    'assets/images/ic_inform_parla.png', //7
    'assets/images/ic_diario_oficial.png', //8
    'assets/images/ic_escola.png', //9
    'assets/images/ic_regimento_alba.png', //10
    'assets/images/ic_constituicao_ba.png', //11
    'assets/images/ic_partidos.png', //12
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: new GridView.builder(
            itemCount: _filesNome.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                child: new InkResponse(
                  child: Image.asset(_filesNome[index]),
                  onTap: () {
                    _routesNavigations(context, index);
                  },
                ),
              );
            }),
      ),
    );
  }

  _routesNavigations(BuildContext context, int id) {
    switch (id) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceMesaDirWidget()));
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceComissoesWidget()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlacePainelPlenaWidget()));
        break;
      case 3:
        _launchURL("https://www.al.ba.gov.br/atividade-legislativa-nova/proposicoes");
        /*
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlacePautaWidget())); */
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceTVAlbaWidget()));
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceRadioAlbaWidget()));
        break;
      case 6:
        _launchURL("https://www.al.ba.gov.br/midia-center/alba-cultural");
        /*
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceAlbaCultWidget()));*/
        break;
      case 7:
        _launchURL("https://www.al.ba.gov.br/servicos/informativo-parlamentar");
        break;
      case 8:
        _launchURL("http://egbanet.egba.ba.gov.br/alba");
        break;
      case 9:
        _launchURL("https://www.al.ba.gov.br/servicos/escola-legislativo");
        break;
      case 10:
        _launchURL("https://www.al.ba.gov.br/atividade-legislativa/legislacao/regimento-interno");
        break;
      case 11:
        _launchURL("https://www.al.ba.gov.br/atividade-legislativa/legislacao/constituicao-estadual");
        break;
      case 12:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlacePartidosWidget()));
        break;
    }
  }

  _launchURL(String urlNew) async {
    var url = urlNew;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}