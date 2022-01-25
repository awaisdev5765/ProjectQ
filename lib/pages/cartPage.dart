import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hambal/model/foodcart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  GlobalKey<FormState> key = GlobalKey();

  getTotalPrice() {
    double price = 0;
    FoodCart.items.forEach((index) {
      price = price + (index.price * index.number);
    });
    return price.toStringAsFixed(2);
  }

  Color ic2 = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  Color ic1 = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Material(
          elevation: 4,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.4))
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Material(
                            color: ic2,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              onHover: (value) {
                                if (value) {
                                  if (ic2 != Colors.grey.withOpacity(0.3))
                                    setState(() {
                                      ic2 = Colors.grey.withOpacity(0.3);
                                    });
                                } else if (ic2 != Colors.white)
                                  setState(() {
                                    ic2 = Colors.white;
                                  });
                              },
                              child: CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.transparent,
                                child: InkWell(
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 26,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.4))
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Material(
                            color: ic1,
                            child: InkWell(
                              onTap: () {},
                              onHover: (value) {
                                if (value) {
                                  if (ic1 != Colors.grey.withOpacity(0.3))
                                    setState(() {
                                      ic1 = Colors.grey.withOpacity(0.3);
                                    });
                                } else if (ic1 != Colors.white)
                                  setState(() {
                                    ic1 = Colors.white;
                                  });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 23,
                                child: InkWell(
                                  child: Icon(
                                    Icons.favorite,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: FoodCart.items.length + 1,
              itemBuilder: (context, index) => index == FoodCart.items.length
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10.0),
                        child: Text('Total BD' + getTotalPrice(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    )
                  : Card(
                      elevation: 2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                  FoodCart.items[index].name +
                                      ' X ' +
                                      FoodCart.items[index].number.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    FoodCart()
                                        .removeItem(FoodCart.items[index]);
                                    setState(() {});
                                  },
                                  child: CircleAvatar(
                                    radius: 13,
                                    backgroundColor: Colors.black,
                                    child: Center(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'BD' +
                                        (FoodCart.items[index].price *
                                                FoodCart.items[index].number)
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                      )),
            )),
      ),
    );
  }
}
