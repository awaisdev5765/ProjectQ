//import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hambal/home.dart';

class DisplayMenu extends StatefulWidget {
  final RouteSettings param;

  const DisplayMenu({Key key, this.param}) : super(key: key);
  @override
  _DisplayMenuState createState() => _DisplayMenuState();
}

class _DisplayMenuState extends State<DisplayMenu> {
  void download(String url) {
    //html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    //anchorElement.download = url;
    //anchorElement.click();
  }

  void initState() {
    super.initState();
    String t = widget.param.name.split('/')[1];
    String name = t.isEmpty ? 'delhipalace' : t;
    download("http://api.hambal.io/digmenu/${name}.pdf");
 Navigator.of(context).pushReplacement(CupertinoPageRoute(
                   builder: (context) =>
                       landingPage(param: widget.param.name.split('/')[1])));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffa020f0),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/splash.jpg",
              height: double.maxFinite,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: (MediaQuery.of(context).size.height / 100) / 15,
            child: Center(
                child: Text('Menu is Downloading...',
                    maxLines: 4,
                    style: TextStyle(fontSize: 18, color: Colors.white))),
          )
        ],
      ),
    );
  }
}
