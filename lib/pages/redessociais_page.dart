import 'package:alba_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class PlaceRedesSociaisWidget extends StatefulWidget {
  PlaceRedesSociaisWidget();
  @override
  _PlaceRedesSociaisWidgetState createState() =>
      _PlaceRedesSociaisWidgetState();
}

class _PlaceRedesSociaisWidgetState extends State<PlaceRedesSociaisWidget> {
  List<String> _filesNome = [
    'assets/images/ic_facebook_n.png',
    'assets/images/ic_insta_n.png',
    'assets/images/ic_twitter_n.png',
    'assets/images/ic_flickr_n.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004a92),
        centerTitle: true,
        title: Image.asset(
          "assets/images/marca_mobi.png",
          width: 100.0,
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(
        child: new GridView.builder(
            itemCount: 4,
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
        Uri urlNew = Uri.parse("https://www.facebook.com/legislativodabahia");
        _launchURL(urlNew);
        break;
      case 1:
        Uri urlNew = Uri.parse("https://www.instagram.com/legislativoalba/?igshid=154rgjpxiz9er");
        _launchURL(urlNew);
        break;
      case 2:
        Uri urlNew = Uri.parse("https://twitter.com/LegislativoAlba");
        _launchURL(urlNew);
        break;
      case 3:
        Uri urlNew = Uri.parse("https://www.flickr.com/photos/presidenciaalba/");
        _launchURL(urlNew);
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