import 'dart:async';

import 'package:flutter/material.dart';

final Color mainColor = Color(0xffa020f0);
navigateClearStack(BuildContext context, Widget route) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => route),
      ModalRoute.withName("/ROOT"));
}

Future<void> navigate(BuildContext context, Widget page) async {
  var nav = Navigator.of(context);
  var route = MaterialPageRoute(builder: (context) => page);
  nav.push(route);
}

navigateString(BuildContext context, Widget page) {
  Navigator.push<String>(
      context, MaterialPageRoute(builder: (context) => page));
}

setTimeoutMs(void callback(Timer timer), int time) {
  Timer timer;
  timer = Timer(Duration(milliseconds: time), () {
    callback(timer);
  });
}
