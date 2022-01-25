import 'package:flutter/material.dart';
import 'package:hambal/home.dart';
import 'package:hambal/pages/addingPage.dart';
import 'package:hambal/pages/cartPage.dart';
import 'package:hambal/pages/displaymenu.dart';
import 'package:hambal/pages/menuPage.dart';
import 'package:hambal/pages/reservationPage.dart';
import 'package:hambal/pages/selectionPage.dart';
import 'package:hambal/path.dart' as m;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static List<m.Path> paths = [
    m.Path(
      '/menu',
      (context, param) => menuPage(),
    ),
    m.Path(
      '/reservation',
      (context, param) => ReservationPage(),
    ),
    m.Path(
      '/cart',
      (context, param) => CartPage(),
    ),
    m.Path(
      '/details',
      (context, param) => addingPage(
        args: param.arguments,
      ),
    ),
    m.Path(
      r'^/[A-Za-z]+',
      (context, param) => DisplayMenu(param: param),
    ),
    m.Path(
      r'^/',
      (context, param) => landingPage(param: param.name.split('/')[1]),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(fontFamily: "CeraRoundPro"),
      // initialRoute: '/',
      onGenerateRoute: (settings) => onGenerateRoute(settings),
      // onUnknownRoute: (value) {
      //   return MaterialPageRoute<void>(
      //       builder: (context) => landingPage(), settings: value);
      // }

      // routes: {
      //   '/': (context) => landingPage(),
      //   '/digitalmenu/' + RegExp('([A-Za-z])+').pattern: (context) =>
      //       DisplayMenu(),
      // },
    );
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (m.Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name)) {
        final firstMatch = regExpPattern.hasMatch(settings.name);
        // final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
        if (firstMatch)
          return MaterialPageRoute<void>(
            builder: (context) => path.builder(context, settings),
            settings: settings,
          );
        else
          return null;
      }
    }
    // If no match is found, [WidgetsApp.onUnknownRoute] handles it.
    return null;
  }
}
