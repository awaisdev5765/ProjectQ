import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hambal/model/constant.dart';
import 'package:hambal/pages/menuPage.dart';
import 'package:hambal/pages/reservationPage.dart';
import 'package:hambal/utils/utils.dart';

class selectionPage extends StatefulWidget {
  @override
  _selectionPageState createState() => _selectionPageState();
}

class _selectionPageState extends State<selectionPage> {
  List<String> names = ['Alpha', 'Beta', 'Cupcake', 'Donut'];
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  final Color color = Color(0xffa020f0);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        controller: scrollController,
        // radius: Radius.circular(5),
        // thickness: 8,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // image below the top bar
                    child: SizedBox(
                      height: media.height * 0.60,
                      width: media.width,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.asset(
                            'assets/cover.png',
                            fit: BoxFit.cover,
                          ),

                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Welcome To",
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            currentName == null
                                ? 'Aziz Cafe'
                                : currentName.toString().isEmpty
                                    ? 'Aziz Cafe'
                                    : currentName.toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 29.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/menu');
                    // navigateClearStack(context, menuPage());
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      decoration: BoxDecoration(
                        color: color,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                //   margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "DINE IN ",
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontFamily: "CeraRoundPro",
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )),
                          ),

                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.utensilSpoon,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                FontAwesomeIcons.wineGlassAlt,
                                color: Colors.white,
                                size: 25,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),

            ],
          ),
        ),
      ),
    );
  }
}



//Padding(
//padding: const EdgeInsets.only(top: 15.0),
//child: Center(
//child: CircleAvatar(
//backgroundColor: Colors.white,
//radius: media.height / 100 * 18,
//backgroundImage: AssetImage(
//'assets/logo.jpg',
//),
/// child: Image.asset(
//   'assets/logo.jpg',
//   height: media.width / 100 * 10,
//   width: media.width / 100 * 10,
//   fit: BoxFit.fill,
// /),
//),
//),

