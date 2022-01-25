import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hambal/ResponsivePage/Responsive.dart';
import 'package:hambal/model/MenuItems.dart';
import 'package:hambal/model/food.dart';
import 'package:hambal/model/foodcart.dart';
import 'package:hambal/utils/iconClass.dart';

const Klable2Text = TextStyle(fontSize: 29.0, fontWeight: FontWeight.w900);

class addingPage extends StatefulWidget {
  final Map<String, dynamic> args;
  // final int id;
  // final MenuItem item;
  const addingPage({Key key, this.args}) : super(key: key);
  @override
  _addingPageState createState() => _addingPageState();
}

class _addingPageState extends State<addingPage> {
  List<ProductModel> cart = [];
  int id;
  MenuItem item;
  int note = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.args['id'];
    item = widget.args['item'];

    final z = FoodCart.items.where((element) => element.id == id).toList();
    if (z.length > 0) note = z[0].number;
  }

  @override
  Widget build(BuildContext context) {
    String s = "\$";

    var media = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: InkWell(
            onTap: () {
              bool contains = false;
              for (int i = 0; i < FoodCart.items.length; i++) {
                Food z = FoodCart.items[i];
                if (z.id == id) {
                  FoodCart.items[i].number = FoodCart.items[i].number + note;
                  contains = true;
                  break;
                }
              }
              if (contains == false) {
                FoodCart().additem(Food(id, "${item.name}",item.price, note));
              }
              Navigator.of(context).pop();
            },
            child: Container(
              child: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              height: 50,
              color: color,
            )),
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                // image below the top bar
                child: SizedBox(
                  height: media.height * 0.45,
                  width: media.width,
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(strokeWidth: 2.0,),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    child: Icon(
                      Icons.arrow_back,
                      size: 21,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Center(
                heightFactor: 1,
                child: Padding(
                    padding: EdgeInsets.only(
                      top: media.height * 0.49,
                      left: media.width / 10,
                      right: media.width / 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                            child: Text(
                          item.name,
                          style: Klable2Text,
                        )),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(item.description,style: TextStyle(color: Colors.grey),)),
                        Container(
                            // width: media.width / 0.95,
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[300],
                              border: Border.all(color: Colors.grey[300]),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: RoundIconButton(
                                    icon: FontAwesomeIcons.minus,
                                    onPressed: () {
                                      if (note <= 1) {
                                        return;
                                      }
                                      setState(() {
                                        note--;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    note.toString(),
                                    style: Klable2Text,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: RoundIconButton(
                                    icon: FontAwesomeIcons.plus,
                                    onPressed: () {
                                      setState(() {
                                        note++;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            "BD " + getPrice().toStringAsFixed(2),
                            style: Klable2Text,
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double getPrice() {
    return note * item.price;
  }
}
