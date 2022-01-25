import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:hambal/utils/utils.dart';

class testApi extends StatefulWidget {
  @override
  _testApiState createState() => _testApiState();
}

class _testApiState extends State<testApi> {
  void download(String url) {
    html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  void initState() {
    super.initState();
    download("http://api.hambal.io/digmenu/DELHIPALACE.pdf");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text('Go To Resturant Menu')),
      body: Container(),
    );
  }
}
