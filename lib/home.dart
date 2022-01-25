import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hambal/model/constant.dart';
import 'package:hambal/pages/selectionPage.dart';
import 'package:page_transition/page_transition.dart';

class landingPage extends StatefulWidget {
  final dynamic param;

  const landingPage({Key key, this.param}) : super(key: key);

  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentName = widget.param;
  }

  @override
  Widget build(BuildContext context) {
    // Timer timer = Timer(Duration(milliseconds: 3000), () {
    //   var route = ModalRoute.of(context);
    //   print(route?.settings?.name);
    //   Navigator.pushReplacement(
    //       context,
    //       PageTransition(
    //           type: PageTransitionType.rightToLeftWithFade,
    //           duration: Duration(seconds: 1),
    //           curve: Curves.easeIn,
    //           alignment: Alignment.centerLeft,
    //           child: selectionPage()));
    // });
    // TODO: implement build
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return selectionPage();
          return Scaffold(
            backgroundColor: Color(0xffa020f0),
            body: Center(
              child: Image.asset(
                "assets/splash.jpg",
                height: double.maxFinite,
                fit: BoxFit.contain,
              ),
            ),
          );
        });
    // return MaterialApp(
    //   home: Scaffold(
    //     backgroundColor: Color(0xffa020f0),
    //     body: Center(
    //       child: Image.asset(
    //         "assets/splash.jpg",
    //         height: double.maxFinite,
    //         fit: BoxFit.fill,
    //       ),
    //     ),
    //   ),
    // );
  }
}
