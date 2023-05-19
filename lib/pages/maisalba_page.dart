import 'package:alba_app/pages/comissoes_page.dart';
import 'package:alba_app/pages/painelplena_page.dart';
import 'package:alba_app/pages/partidos_page.dart';
import 'package:alba_app/pages/radioalba_page.dart';
import 'package:alba_app/pages/tvalba_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mesadir_page.dart';

class PlaceMaisAlbaWidget extends StatefulWidget {
  PlaceMaisAlbaWidget();
  @override
  _PlaceMaisAlbaWidgetState createState() => _PlaceMaisAlbaWidgetState();
}

class _PlaceMaisAlbaWidgetState extends State<PlaceMaisAlbaWidget> {
  List<String> _filesNome = [
    'assets/images/ic_comissoes.png', //0
    'assets/images/ic_pautas_comiss.png', //1
    'assets/images/ic_plenario.png', //2
    'assets/images/ic_pauta.png', //3
    'assets/images/ic_tvalba.png', //4
    'assets/images/ic_radio.png', //5
    'assets/images/ic_mesa_dir.png',//6
    'assets/images/ic_alba_cult.png', //7
    'assets/images/ic_inform_parla.png', //8
    'assets/images/ic_diario_oficial.png', //9
    'assets/images/ic_escola.png', //10
    'assets/images/ic_regimento_alba.png', //11
    'assets/images/ic_constituicao_ba.png', //12
    'assets/images/ic_partidos.png', //13
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
            MaterialPageRoute(builder: (context) => PlaceComissoesWidget()));
        break;
      case 1:
        Uri urlNew = Uri.parse("https://www.al.ba.gov.br/comissoes/resumo-pauta");
        print(urlNew);
        _launchURL(urlNew);
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlacePainelPlenaWidget()));
        break;
      case 3:
        Uri urlNew = Uri.parse("https://www.al.ba.gov.br/atividade-legislativa-nova/proposicoes");
        _launchURL(urlNew);
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceMesaDirWidget()));
        break;
      case 7:
        Uri urlNew = Uri.parse("https://www.al.ba.gov.br/midia-center/alba-cultural");
        _launchURL(urlNew);
        /*
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceAlbaCultWidget()));*/
        break;
      case 8:
        Uri urlNew = Uri.parse("https://www.al.ba.gov.br/servicos/informativo-parlamentar");
        _launchURL(urlNew);
        break;
      case 9:
        Uri urlNew = Uri.parse("http://egbanet.egba.ba.gov.br/alba");
        _launchURL(urlNew);
        break;
      case 10:
        Uri urlNew = Uri.parse("https://www.al.ba.gov.br/servicos/escola-legislativo");
        _launchURL(urlNew);
        break;
      case 11:
        Uri urlNew = Uri.parse("https://www.al.ba.gov.br/atividade-legislativa/legislacao/regimento-interno");
        _launchURL(urlNew);
        break;
      case 12:
        Uri urlNew = Uri.parse("https://www.al.ba.gov.br/atividade-legislativa/legislacao/constituicao-estadual");
        _launchURL(urlNew);
        break;
      case 13:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlacePartidosWidget()));
        break;
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
}