import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hambal/model/MenuItems.dart';
import 'package:hambal/model/foodcart.dart';
import 'package:hambal/pages/addingPage.dart';
import 'package:hambal/pages/cartPage.dart';
import 'package:hambal/pages/selectionPage.dart';
import 'package:hambal/utils/iconClass.dart';
import 'package:hambal/utils/utils.dart';

class menuPage extends StatefulWidget {
  @override
  _menuPageState createState() => _menuPageState();
}

class _menuPageState extends State<menuPage> {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  Map<String, List<MenuItem>> items;
  int oldValue = 0;

  @override
  void initState() {
    super.initState();
    oldValue = FoodCart.items.length;
    startTimer();
    items = {
      "Ramadan Special": [
        MenuItem(
            id: 1,
            description:
            "golden fried samboosa with Feta cheese filling",
            imageUrl:
           "https://images.unsplash.com/photo-1604917877934-07d8d248d396?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Zm9vb2R8ZW58MHx8MHx8&w=1000&q=80",
               name: 'Feta Cheese Samboosa',
            price: 1.769),
        MenuItem(
            id: 2,
            description:
            "Golden fried samboosa with Classic cream cheese filling",
            imageUrl:
         "data:image/jpeg;base64,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",
             name: 'Classic Cheese Samboosa',
            price: 1.769),
        MenuItem(
            id: 3,
            description:
            "Pulled chicken infused with traditonal bomaby green chutney and feta cheese",
            imageUrl:
            "https://pbs.twimg.com/media/BPYluKACYAASbL6.jpg",
            name: 'Bombay Chicken Roll',
            price: 2.218),
        MenuItem(
            id: 4,
            description:
            "Pulled chicken with home made buffalo sauce and cheese",
            imageUrl:
           "https://pbs.twimg.com/profile_images/458221125609078784/yTMjsTbX_400x400.jpeg",
            name: 'Buffalo Chicken Roll',
            price: 2.212),
        MenuItem(
            id: 5,
            description:
            "chickpeas , onion, cilantro  tossed with crispy bread topped with home made vine leaves and yougurt  molasess sauce ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Ramadan%20Special/Wine%20Leaves%20Fettah.jpg?fbclid=IwAR1Rf8qpPCa36N9r-iHUiZpCKFYBNu33OgD_0ByuW2tqiTgmVZkxJn6pGuo",

            name: 'Wine Leaves Fettah',
            price: 3.795),
        MenuItem(
            id: 6,
            description:
            "Saffron Risotto rice topped with slow cooked molasses short ribs boneless",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Ramadan%20Special/Aziz%20Saffron%20Short%20Ribs.jpg?fbclid=IwAR1Rf8qpPCa36N9r-iHUiZpCKFYBNu33OgD_0ByuW2tqiTgmVZkxJn6pGuo",

            name: 'Aziz Saffron Short Ribs',
            price: 9.216),
        MenuItem(
            id: 7,
            description:
            "Traditional chicken kibbah",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Ramadan%20Special/Kibbah%20chicken.jpg?fbclid=IwAR1Rf8qpPCa36N9r-iHUiZpCKFYBNu33OgD_0ByuW2tqiTgmVZkxJn6pGuo",

            name: 'Kibbah chicken ',
            price: 2.223),
        MenuItem(
            id: 8,
            description:
            "Traditional beef kibbah",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Ramadan%20Special/Kibbah%20Beef.jpg?fbclid=IwAR1Rf8qpPCa36N9r-iHUiZpCKFYBNu33OgD_0ByuW2tqiTgmVZkxJn6pGuo",

            name: 'Kibbah Beef',
            price: 2.800),



      ],
      "BreakFast": [
        MenuItem(
            id: 9,
            description:
            "",
            imageUrl:
            'https://hambal.io/azizcafe/Menu/Breakfast/Fried%20Halloumi%20Cheese%20Bao%20%281%29.jpg',
            name: 'Fried Halloumi Cheese Bao',
            price: 3.5),
        MenuItem(
            id: 10,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Scrambled%20Egg%20Bao.jpg?fbclid=IwAR0_Ynb5V_kRw75Pvc0ghWJTPOhHW2P2xRUfmXBLdhP-R3fCOjA2MTct-js",
            name: 'Scrambled Egg Bao',
            price: 3.4),
        MenuItem(
            id: 11,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Egg%20And%20Bacon%20Bao.jpg",
            name: 'Egg And Bacon Bao',
            price: 3.8),
        MenuItem(
            id: 12,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Shakouka%20Bao.jpg",
            name: 'Shakshuka Bao',
            price: 2.8),
        MenuItem(
            id: 13,
            description:
            "Eggplant with tahini sauce and falafel topped with sateed garlic",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/FalafelFattah.jpeg",
            name: 'Falafel Fettah',
            price: 3.9),
        MenuItem(
            id: 14,
            description:
            "Traditional Bahraini Shakshouka",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Shakshouka.jpg",
            name: 'Shakshoka',
            price: 1.9),
        MenuItem(
            id: 15,
            description:
            "Sunny side up egg with halloumi cheese guacamole, grilled tomato,potato bun and hollandaise sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Halloumi%20Egg%20Benedict.jpg",
            name: 'Halloumi Egg Benedict',
            price: 3.4),
        MenuItem(
            id: 16,
            description:
            "French toast with multi layer cream and blueberry filling topped with fresh berries and maple syurp and castor sugar",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Aziz%20French%20Toast.jpg",
            name: 'Aziz French Toast',
            price: 4.5),
        MenuItem(
            id: 17,
            description:
            "Tradition Egg And Tomato",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Egg%20And%20Tomato.jpg",
            name: 'Egg And Tomato',
            price: 1.9),
        MenuItem(
            id: 18,
            description:
            "Keema meat on bed of hummos",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Hummos%20Bin%20Lahme.jpg",
            name: 'Hummos Bin Lahme',
            price: 2.2),
        MenuItem(
            id: 19,
            description:
            "Crepe with turkey bacon filling and cheese topped with hollandaise sauce ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Florentine%20Turkey%20Bacon%20Crepe.jpg",
            name: 'Florentine Turkey Bacon Crepe',
            price: 3.2),
        MenuItem(
            id: 20,
            description:
            "Crepe with Chicken filling and cheese topped with hollandaise sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Florentine%20Chicken%20Crepe.jpg",
            name: 'Florentine Chicken Crepe',
            price: 2.9),
        MenuItem(
            id: 21,
            description:
            "Traditional Egg And Tomato With Sausage",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Sausage%20Egg%20And%20Tomato.jpg",
            name: 'Egg And Tomato With Sausage',
            price: 2.2),
        MenuItem(
            id: 22,
            description:
            "French Toast infused with mahywa sauce and Turkey Beef Filling",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Mahyawa%20French%20toast%20Tukey%20Bacon.jpg",
            name: 'Aziz Mahyawa French Toast (Turkey,Beef)',
            price: 3.8),
        MenuItem(
            id: 23,
            description:
            "French toast infused with mahywa sauce and Egg and Cheese Filling",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Mahyawa%20French%20Toast%20Egg%20And%20Cheese.jpg",
            name: 'Aziz Mahyawa French Toast Egg And Cheese',
            price: 3.2),
        MenuItem(
            id: 24,
            description:
            "Traditional Fava Foul",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Foul%20Madammas.jpg",
            name: 'Fava Foul',
            price: 1.9),
        MenuItem(
            id: 25,
            description:
            "Manakish topped with halloumi cheese, Zaatar and olives",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Halloumi%20Zatar%20Manakeeseh.jpg",
            name: 'Halloumi Zaatar ManaKish',
            price: 2.2),
        MenuItem(
            id: 26,
            description:
            "Manakish topped with labneh, Zaatar and olives",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Labnah%20Zatar%20Mankeeseh.jpg",
            name: 'Labneh Zaatar ManaKish',
            price: 2.2),
        MenuItem(
            id: 27,
            description:
            "Bahraini bread spread with egg and cheese with spices little spicy",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Lulu%20Quesdilia%20Bahraini%20Style%20Egg%20and%20cheese.jpg",
            name: 'Lulu Quesadilla Bahraini Style Egg And Cheese',
            price: 2.6),
        MenuItem(
            id: 28,
            description:
            "Bahraini bread spread with meat and cheese with spices little spicy",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Lulu%20Quesadilia%20Bahraini%20Style%20%28meat%20and%20cheese%29.jpg",
            name: 'Lulu Quesadilla Bahraini Style Meat And Cheese',
            price: 2.7),
        MenuItem(
            id: 29,
            description:
            "Grilled halloumi cheese with tomato and olives",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Grilled%20Halloumi%20Cheese.jpg",
            name: 'Grilled Halloumi Cheese',
            price: 2.9),
        MenuItem(
            id: 30,
            description:
            "saffron flavoured vermicillli infused with milk and pistachio served along with fried Egg on top",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Mudaleel%20Balaleet.jpg",
            name: 'Mudallal Balaleet',
            price: 2.1),
        MenuItem(
            id: 31,
            description:
            "Traditional Foul Madammas",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Breakfast/Foul%20Madammas.jpg",
            name: 'Foul Madammas',
            price: 1.9),
      ],
      "Soup": [
        MenuItem(
            id: 32,
            description:
            "Cream of Mushroom Soup",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Soup/Cream%20Of%20Mushroom%20Soup.jpg",
            name: 'Cream of Mushroom',
            price: 1.9),

        MenuItem(
            id: 33,
            description:
            "Cream of Chicken Soup",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Soup/Cream%20Of%20Chicken%20Soup.jpg",
            name: 'Cream of Chicken',
            price: 1.9),
      ],
      "Salad": [
        MenuItem(
            id: 34,
            description:
            "Fried halloumi cheese with avocado fresh veggies and pomegranate seeds and topped with roman molasses",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Salads/Fried%20halloumi%20Salad.jpg",
            name: 'Fried Halloumi Cheese Salad',
            price: 3.8),
        MenuItem(
            id: 35,
            description:
            "Fresh Leafy vegetables with cherry tomatoes,Avocado,mango along with Feta cheese topped with italian dressing",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/Tropical%20Greek%20Salad.jpg",
            name: 'Tropical Greek Salad',
            price: 3.5),
        MenuItem(
            id: 36,
            description:
            "Frech Leafy Vegetables with crispy chicken topped with grated fresh coconut, Indian mixture and special house made Tangy dressing ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/Chicken%20Mak%20Tai%20Salad.jpg",
            name: 'Chicken MakTai Salad',
            price: 3.5),
        MenuItem(
            id: 37,
            description:
            "Crispy fried falafel with chick peas, tomato,lettuce mixed with home made tahina sauce and topped with dynamite sauce and dill seeds",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Salads/Felafel%20salad.jpg",
            name: 'Falafel Salad',
            price: 3),
        MenuItem(
            id: 38,
            description:
            "Fresh iceberg lettuce and Rocca leaves, frizzy with mandarin topped with crispy crunchies and sweet and spices homemade",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Salads/Crunchy%20chicken%20Salad.jpg",
            name: 'Crunchy Chicken Salad',
            price: 3.2),
        MenuItem(
            id: 39,
            description:
            "Grilled halloumi cheese with wild rocket leaves and zereshk topped with parmesan cheese and italian sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Salads/Oriental%20Rocka%20Salad.jpg",
            name: 'Oriental Rocco Salad',
            price: 3.5),
        MenuItem(
            id: 40,
            description:
            "Beetroot and sauteed quinoa with yogurt sauce and grilled Chicken with sumac",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Salads/Beetroot%20Quinoa%20Chicken%20Salad.jpg",
            name: 'Beetroot Quinoa Chicken Salad',
            price: 3.5),
        MenuItem(
            id: 41,
            description:
            "Regular fattoush salad with lemongrass flavor",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Salads/Thai%20Fatoush.jpg",
            name: 'Thai Fattoush Salad',
            price: 2.6),
        MenuItem(
            id: 42,
            description:
            "Iceberg lettuce with chicken and caesar dressing",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Salads/Chicken%20Ceaser%20Salad.jpg",
            name: 'Chicken Caesar Salad',
            price: 2.9),
      ],
      "Starter": [
        MenuItem(
            id: 43,
            description:
            "Baduanjin with tahini sauce and falafel topped with sauteed garlic",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Starters/Felafel%20Fettah.jpg",
            name: 'Falafel Fettah',
            price: 3.9),
        MenuItem(
            id: 44,
            description:
            "Crispy fried hamour served with sweet chilly sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Starters/Hamour%20Tempura.jpg",
            name: 'Hamour Tempura',
            price: 2.9),
        MenuItem(
            id: 45,
            description:
            "Deep fried prawns in dynamite sauce 7 pieces (not spicy)",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Starters/Dynamite%20Prawns.jpg",
            name: 'Dynamite Prawn',
            price: 3.8),
        MenuItem(
            id: 46,
            description:
            "4 piece of crispy dough shrimps in sweet and tangy sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Starters/Wonton%20Cup%20Prawns.jpg",
            name: 'Wonton Cup Prawns',
            price: 2.9),
        MenuItem(
            id: 47,
            description:
            "Bahraini chicken kebab served with spicy sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Starters/Bahraini%20Chicken%20Kebab.jpg",
            name: 'Bahraini Chicken kebab',
            price: 2),
        MenuItem(
            id: 48,
            description:
            "4 piece of potato cheese balls served with omani chips and non spicy homemade sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Starters/Potato%20Omani%20Cheese%20Balls.jpg",
            name: 'Potato Omani Cheese Balls',
            price: 2.5),
        MenuItem(
            id: 49,
            description:
            "4 piece of risotto balls  blended with mahyawa sauce.",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Starters/Mahyawa%20Risotto%20Balls.jpg",
            name: 'Mahyawa Risotto Balls',
            price: 2.8),
      ],
      "Cold Starter": [
        MenuItem(
            id: 50,
            description:
            "Hummus with lemon grass flavour",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Cold%20Starters/Thai%20Hummos.jpg",
            name: 'Thai Hummus',
            price: 1.8),
        MenuItem(
            id: 51,
            description:
            "Madrooba rice with minced chicken and roma molasses wrapped in vine leaves",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Cold%20Starters/Madrooba%20Vine%20Leaves.jpg",
            name: 'Madrooba Vine Leaves',
            price: 1.4),
        MenuItem(
            id: 52,
            description:
            "Fried falafel and eggplant on bed of hummus",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Cold%20Starters/Shami%20Maza.jpg",
            name: 'Shami Maza',
            price: 1.9),
        MenuItem(
            id: 53,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Cold%20Starters/Hummos.jpg",
            name: 'Hummus',
            price: 1.7),
      ],
      "Bao": [
        MenuItem(
            id: 54,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/Chilli%20Ribs%20Bao.jpg",
            name: 'Chilli Ribs Bao',
            price: 4.1),
        MenuItem(
            id: 55,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/BBQ%20Ribs%20Bao%20%281%29.jpg",
            name: 'BBQ Ribs Bao',
            price: 4.1),
        MenuItem(
            id: 56,
            description:
            "Shrimp Balls with house made peanut and chili butter sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/Shrimp%20Ball%20Bao.jpg",
            name: 'Shrimp Ball Bao',
            price: 2.4),
        MenuItem(
            id: 57,
            description:
            "Crispy Chicken with house made chili mayonnaise",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/Crispy%20Chicken%20Bao.jpg",
            name: 'Crispy Chicken Bao',
            price: 2.2),
        MenuItem(
            id: 58,
            description:
            "Grilled chicken with Chili Thai Sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/Thai%20Chicken%20Bao.jpg",
            name: 'Thai Chicken Bao',
            price: 2.2),

      ],
      "Main Course": [
        MenuItem(
            id: 59,
            description:
            "Aziz special Prawn Biryani with authentic spices and flavours served with youghurt sauce (little spicy)",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Aziz%20Prawn%20Biriyani.jpg",
            name: 'Prawn Biryani',
            price: 3.8),
        MenuItem(
            id: 60,
            description:
            "Aziz special Chicken Biryani with authentic spices and flavours served with youghurt sauce (little spicy)",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Aziz%20Chicken%20Biriyani.jpg",
            name: 'Chicken Biryani',
            price: 3.5),
        MenuItem(
            id: 61,
            description:
            "Baked band jam on top of fried fattoush bread topped with homemade sauce, 4 pieces of meatballs and youghurt sauce ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Fettat%20Kofta.jpg",
            name: 'Fattet Kofta',
            price: 3.8),
        MenuItem(
            id: 62,
            description:
            "Baked pasta with 4 kinds of cheese and chicken and topped with lebanese chicken liver",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Bu%20Aqeel.jpg",
            name: 'Bu Aqeel',
            price: 4.5),
        MenuItem(
            id: 63,
            description:
            "Soft and tender chicken served with saffron infused rice with creamy saffron sauce little spicy",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Creamy%20Saffron%20Prawn%20%282%29.jpg",
            name: 'Creamy Saffron Chicken',
            price: 3.9),
        MenuItem(
            id: 64,
            description:
            "Soft and tender prawn served with saffron infused rice with creamy saffron sauce little spicy",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Creamy%20Saffron%20Prawn%20%282%29.jpg",
            name: 'Creamy Saffron Prawn',
            price: 4.5),
        MenuItem(
            id: 65,
            description:
            "Soft and crispy chicken strips served with french fries and homemade sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Crispy%20chicken%20Stripes.jpeg",
            name: 'Crispy Chicken Strips',
            price: 3.5),
        MenuItem(
            id: 66,
            description:
            "2 piece of tender chicken breast part with creamy mushroom sauce and served with mashed potato",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Chicken%20Mushroom%20Steak.jpg",
            name: 'Chicken Mushroom Steak',
            price: 3.8),
        MenuItem(
            id: 67,
            description:
            "Spicy Risotto rice served with sausage and salmon spicy ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Salmon%20Jambaliya.jpg",
            name: 'Salmon Jambaliya',
            price: 3.7),
        MenuItem(
            id: 68,
            description:
            "Spicy Risotto rice served with sausage and prawn spicy ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Prawns%20Jambaliya.jpg",
            name: 'Prawns Jambaliya',
            price: 3.9),
        MenuItem(
            id: 69,
            description:
            "Grilled hamour served with white rice and lentil sauce",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Hammour%20Dal.jpeg",
            name: 'Hamour Dal',
            price: 3.8),
        MenuItem(
            id: 70,
            description:
            "Grilled Salmon with basil and capers served with fresh salad and vinaigrette",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Grilled%20Basil%20Salmon.jpg",
            name: 'Grilled Basil Salmon',
            price: 5.8),
        MenuItem(
            id: 71,
            description:
            "Kushari rice served with meat balls and home made sauce and crunchies",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Crispy%20kushari%20Meat%20balls.jpg",
            name: 'Crispy Kushari Meat Balls',
            price: 3.5),
        MenuItem(
            id: 72,
            description:
            "Barbeque short ribs served with Aziz special Machboos rice ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Aziz%20Ribs%20Machboos.jpg",
            name: 'BBQ Ribs Machboos',
            price: 8.5),
        MenuItem(
            id: 73,
            description:
            "Short ribs baked with BBQ sauce and served with mashed potato and creamy BBQ sauce ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Creamy%20BBQ%20Ribs.jpg",
            name: 'Creamy BBQ Ribs',
            price: 7.9),
        MenuItem(
            id: 74,
            description:
            "Aziz special mawash with chef special spices mix and dill flavoured rice served along with prawns",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/prawns%20Mawash.jpg",
            name: 'Prawns Mawash',
            price: 3.8),
        MenuItem(
            id: 75,
            description:
            "Aziz special mawash with chef special spices mix and dill flavoured rice served along with Hamour",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/prawns%20Mawash.jpg",
            name: 'Hamour Mawash',
            price: 3.9),
        MenuItem(
            id: 75,
            description:
            "Jareesh with makhani sauce topped with chicken sauteed bell peppers rocket",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Jereesh%20chicken.jpg",
            name: 'Jareesh Chicken',
            price: 3.8),
        MenuItem(
            id: 76,
            description:
            "Jareesh with makhani sauce topped with prawns sauteed bell peppers rocket",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Jareesh%20prawn.jpg",
            name: 'Jareesh Prawn',
            price: 4.5),
        MenuItem(
            id: 77,
            description:
            "Boneless chicken pieces marinated overnight with chef special house spices and grilled with corn and potato",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Main%20Course/Grilled%20Gerk%20Chicken.jpg",
            name: 'Grilled Gerk Chicken',
            price: 3.8),
      ],
      "Burgers And Sliders": [
        MenuItem(
            id: 78,
            description:
            "Slider with mix cheese sauce and lebanese chicken liver",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/Chicken%20liver%20Slider.jpg",
            name: 'Chicken liver Slider' ,
            price: 1.5),
        MenuItem(
            id: 79,
            description:
            "Slider with mix cheese sauce and lebanese chicken liver along with caramelized onion",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/Chicken%20Liver%20Slider%20With%20Caramalized%20Onion.jpg",
            name: 'Chicken liver Slider With Caramelized',
            price: 1.7),
        MenuItem(
            id: 80,
            description:
            "Crispy chicken slider with pesto sauce and mix cheese",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/Pesto%20chicken%20Slider.jpg",
            name: 'Pesto Chicken Slider',
            price: 2.1),
        MenuItem(
            id: 81,
            description:
            "Crispy chicken slider with Zaatar sauce and mix cheese",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/Zatar%20Chicken%20Slider.jpg",
            name: 'Zaatar Chicken Slider',
            price: 2.2),
        MenuItem(
            id: 82,
            description:
            "Bahraini chicken kebab served with spicy mabooch sauce and mix cheese",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/Mushal%20Wut.jpg",
            name: 'Mushal Wut',
            price: 1.8),
        MenuItem(
            id: 83,
            description:
            "Kofta meat topped with Hummus and caramelized onion with cream cheese ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/LevantSlider.jpeg",
            name: 'Levant Slider',
            price: 2.5),
        MenuItem(
            id: 84,
            description:
            "Pulled Brisket Meat with Creamy BBQ sauce and cheese. ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/Brisket%20Slider.jpg",
            name: 'Classic Brisket Slider',
            price: 2.5),
        MenuItem(
            id: 85,
            description:
            "Angus meat infused with creamy BBQ sauce, Caramelized onion and mushroom",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/Mushroom%20Slider.jpg",
            name: 'Mushroom Slider',
            price: 2.5),
        MenuItem(
            id: 86,
            description:
            'Pulled BBQ short ribs Burger served with potato wedges and mix cheese sauce (400 grams, 5"inch rib) ',
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/BBQ%20Ribs%20Burger.jpg",
            name: 'BBQ Ribs Burger',
            price: 6.8),
        MenuItem(
            id: 87,
            description:
            'Pulled BBQ brisket meat served toasted white bread and mix cheese sauce and french fries ',
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/BBQ%20Brisket%20Sandwich.jpg",
            name: 'BBQ Brisket Sandwich',
            price: 4.5),
        MenuItem(
            id: 88,
            description:
            'Crispy prawns slider served with dynamite sauce and cheese',
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/Dynamite%20prawn%20Slider.jpg",
            name: 'Dynamite Prawn Slider',
            price: 2.2),
        MenuItem(
            id: 89,
            description:
            'Juicy angus beef burger served with potato buns cheddar cheese and pickled cucumber and french fries',
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Burgers%20And%20Sliders/Aziz%20Angus%20Burger.jpg",
            name: 'Aziz Angus Burger',
            price: 3.9),
      ],
      "Pasta": [
        MenuItem(
            id: 90,
            description:
            "Penne Pasta with Rose sauce, Prawn and cheese",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Pasta/Penne%20Rose%20Prawns%20%282%29.jpg",
            name: 'Penne Rose Prawns',
            price: 3.9),
        MenuItem(
            id: 91,
            description:
            "Penne Pasta with Rose sauce, chicken and cheese",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Pasta/Penne%20Rose%20Chicken.jpg",
            name: 'Penne Rose Chicken',
            price: 3.5),
        MenuItem(
            id: 92,
            description:
            "Fettucine pasta with pesto sauce and crispy prawns",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Pasta/Fettucine%20Pesto%20Prawns.jpg",
            name: 'Fettuccine Pesto Prawns',
            price: 4.2),
        MenuItem(
            id: 93,
            description:
            "Fettucine pasta with pesto sauce and crispy chicken",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Pasta/Fettucine%20Pesto%20Chicken.jpg",
            name: 'Fettuccine Pesto Chicken',
            price: 3.8),
        MenuItem(
            id: 94,
            description:
            "Fettucine Alfredo pasta with crispy prawns",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Pasta/Fettucine%20Pesto%20Prawns.jpg",
            name: 'Fettuccine Alfredo Prawns',
            price: 4.2),
        MenuItem(
            id: 95,
            description:
            "Fettucine Alfredo pasta with chicken",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Pasta/Fettucine%20Pesto%20Chicken.jpg",
            name: 'Fettuccine Alfredo Chicken',
            price: 3.8),
        MenuItem(
            id: 96,
            description:
            "Crispy chicken and macaroni topped with flaming Cheetos & Jalapeno",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/Aziz_08139.jpg",
            name: 'Chicky Cheetos',
            price: 4.6),
        MenuItem(
            id: 97,
            description:
            "macroni pasta blended with house made beetroot sauce topped with Crispy fried Prawns and Thahina ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/The%20Red%20Mac.jpg",
            name: 'The Red Mac',
            price: 3.8),
        MenuItem(
            id: 98,
            description:
            "macroni pasta blended with Chef special pesto sauce topped with BBQ Pulled brisket Meat ",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Summer%20Menu/The%20Green%20Brisket%20Mac.jpg",
            name: 'The Green Brisket Mac',
            price: 5.5),


      ],
      "Desserts": [
        MenuItem(
            id: 99,
            description: "Local Bahrain Halwa with cheese wrapped in bread and sauteed served along with scoop of ice cream",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Desserts/Aziz%20Halwa.jpg",
            name: 'Aziz Halwa',
            price: 2.8),
        MenuItem(
            id: 100,
            description: "Bread baked with dried fruits and saffron milk",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Desserts/Lamiya%20cake.jpg",
            name: 'Lamiya Cake',
            price: 3),


      ],

      "Drinks": [
        MenuItem(
            id: 101,
            description:
            "",
            imageUrl:
            "data:image/jpeg;base64,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",
            name: 'Mineral Water',
            price: 0.6),
        MenuItem(
            id: 102,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/perrierwatersparklingwater.jpeg",
            name: 'Perrier Water (Sparkling water)',
            price: 1),
        MenuItem(
            id: 103,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Coca-Cola.jpeg",
            name: 'Coca-Cola',
            price: 0.8),
        MenuItem(
            id: 104,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/DiteCOc.jpg",
            name: 'Dite Coke',
            price: 0.8),
        MenuItem(
            id: 105,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Sprite.jpeg",
            name: 'Sprite',
            price: 0.8),
        MenuItem(
            id: 106,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Fresh%20Orange%20Juice.jpg",
            name: 'Fresh Orange Juice',
            price: 2.2),
        MenuItem(
            id: 107,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Fresh%20Watermelon%20Jucie.jpg",
            name: 'Fresh watermelon',
            price: 2.2),
        MenuItem(
            id: 108,
            description:
            "Fresh strawberry with sprite and mint",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Strawberry%20Mint%20Lemonade.jpg",
            name: 'Strawberry mint Lemonade',
            price: 2.5),
        MenuItem(
            id: 109,
            description:
            "Peach/Lemon",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Iced%20Tea%20PeachLemon.jpg",
            name: 'Iced Tea',
            price: 1.8),
        MenuItem(
            id: 110,
            description:
            "Cream,pineapple and vimto",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Vimto%20Pinacolada.jpg",
            name: 'Vimto Pinacolada',
            price: 2.8),
        MenuItem(
            id: 111,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Fresh%20Lemon%20With%20Mint.jpg",
            name: 'Lemon With Mint',
            price: 2.2),
        MenuItem(
            id: 112,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Watermelon%20Slushie.jpg",
            name: 'Watermelon Slushie',
            price: 2.8),
        MenuItem(
            id: 113,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Saffron%20Sharbat..jpg",
            name: 'Saffron Sharbat',
            price: 2.5),
        MenuItem(
            id: 114,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Blue%20Heaven.jpg",
            name: 'Blue Heaven',
            price: 2),
        MenuItem(
            id: 115,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Passion%20Fruit%20Mojito.jpg",
            name: 'Passion Fruit Mojito',
            price: 2.5),
        MenuItem(
            id: 116,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Cool%20Blue.jpg",
            name: 'Cool Blue',
            price: 1.9),
        MenuItem(
            id: 117,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/Drinks/Karkadi.jpg",
            name: 'Karkadi',
            price: 1.8),
      ],
      "Coffee": [
        MenuItem(
            id: 118,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Spanish%20Latte%20%28Cold%29.jpg",
            name: 'Spanish Latte',
            price: 2.7),
        MenuItem(
            id: 119,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Cappuccino.jpg",
            name: 'Cappuccino',
            price: 1.8),
        MenuItem(
            id: 120,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Turkish%20Coffee.jpg",
            name: 'Turkish Coffee',
            price: 1.8),
        MenuItem(
            id: 121,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Iced%20Americano.jpg",
            name: 'Iced Americano',
            price: 2),
        MenuItem(
            id: 122,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Americano.jpg",
            name: 'Americano',
            price: 1.5),
        MenuItem(
            id: 122,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Espresso%20Single%20%26%20Double.jpg",
            name: 'Espresso (Single)',
            price: 1.2),
        MenuItem(
            id: 123,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Espresso%20Single%20%26%20Double.jpg",
            name: 'Espresso (Double)',
            price: 1.6),
        MenuItem(
            id: 124,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Spanish%20Latte%20%28Hot%29.jpg",
            name: 'Spanish Latte (Hot)',
            price: 2.2),
        MenuItem(
            id: 125,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Flat%20White.jpg",
            name: 'Flat White',
            price: 1.7),
        MenuItem(
            id: 126,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Cafe%20Latte.jpg",
            name: 'Cafe Latte',
            price: 1.8),
      ],

      "Tea": [
        MenuItem(
            id: 127,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Tea.jpg",
            name: 'Jasmine Pearl White',
            price: 2.5),
        MenuItem(
            id: 128,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Tea.jpg",
            name: 'English Breakfast Tea',
            price: 2),
        MenuItem(
            id: 129,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Tea.jpg",
            name: 'Ghamomile Breeze',
            price: 2),
        MenuItem(
            id: 130,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Tea.jpg",
            name: 'Earl Grey Flora',
            price: 2),
        MenuItem(
            id: 131,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Tea.jpg",
            name: 'Green Tea Curl',
            price: 1.5),
        MenuItem(
            id: 132,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Tea.jpg",
            name: 'Jasmine Haze',
            price: 1.5),
        MenuItem(
            id: 133,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Tea.jpg",
            name: 'Royal Assam',
            price: 1.5),
        MenuItem(
            id: 134,
            description:
            "",
            imageUrl:
            "https://hambal.io/azizcafe/Menu/TeaAndCoffee/Tea.jpg",
            name: 'Chai Karak',
            price: 1.2),

      ],

    };
    // scrollController.addListener(() {
    // setState(() {});
    // });
  }

  Timer timer;
  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (FoodCart.items.length != oldValue) {
        oldValue = FoodCart.items.length;
        setState(() {});
      }
    });
  }


  int clickIndex = -1;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      bottomNavigationBar: FoodCart.items.length > 0
          ? BottomAppBar(
        child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/cart');
              // localNavigator(CartPage());
            },
            child: Container(
              height: 50,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      FoodCart.items.length.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              color: color,
            )),
      )
          : Container(
        height: 1,
        width: 1,
      ),
      appBar: AppBar(
        titleSpacing: 2.5,
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => navigate(context, selectionPage()),
          ),
        ),

        // toolbarHeight: 120,
        centerTitle: true,
        title: Text(
          'Menu',
          style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Scrollbar(
        isAlwaysShown: true,
        controller: scrollController,
        // radius: Radius.circular(5),
        // thickness: 8,

        child: Column(
          children: [
            Container(
                height: media.height / 8,
                width: media.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  children: [
                    RaisedButton(
                      color: clickIndex == 0 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        clickIndex = 0;
                        setState(() {});
                        scrollController.animateTo(0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Ramadan Special",
                        style: TextStyle(
                          color: clickIndex == 0 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 1 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        clickIndex = 1;
                        setState(() {});
                        scrollController.animateTo( 550.0 + 550 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "BreakFast",
                        style: TextStyle(
                          color: clickIndex == 1 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 2 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 2;
                        setState(() {});
                        scrollController.animateTo( 2150.0 + 2150 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Soup",
                        style: TextStyle(
                          color: clickIndex == 2 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 3 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 3;
                        setState(() {});
                        scrollController.animateTo( 2320.0 + 2320 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Salad",
                        style: TextStyle(
                          color: clickIndex == 3 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 4 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 4;
                        setState(() {});
                        scrollController.animateTo( 2990.0 + 2990 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                        // scrollController.jumpTo(650);
                      },
                      child: Text(
                        "Starter",
                        style: TextStyle(
                          color: clickIndex == 4 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 5 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        clickIndex = 5;
                        setState(() {});
                        scrollController.animateTo( 3490.0 + 3490 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Cold Starter",
                        style: TextStyle(
                          color: clickIndex == 5 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 6 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 6;
                        setState(() {});
                        scrollController.animateTo( 3800.0 + 3800 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Bao",
                        style: TextStyle(
                          color: clickIndex == 6 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 7 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 7;
                        setState(() {});
                        scrollController.animateTo( 4200.0 + 4200 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Main Course",
                        style: TextStyle(
                          color: clickIndex == 7 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 8? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 8;
                        setState(() {});
                        scrollController.animateTo( 5590.0 + 5590 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Burgers And Sliders",
                        style: TextStyle(
                          color: clickIndex == 8 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    RaisedButton(
                      color: clickIndex == 9 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 9;
                        setState(() {});
                        scrollController.animateTo( 6420.0 + 6420 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Pasta",
                        style: TextStyle(
                          color: clickIndex == 9 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 10 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 10;
                        setState(() {});
                        scrollController.animateTo( 7080.0 + 7080 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Desserts",
                        style: TextStyle(
                          color: clickIndex == 10 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    RaisedButton(
                      color: clickIndex == 11 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 11;
                        setState(() {});
                        scrollController.animateTo( 7260.0 + 7260 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Drinks",
                        style: TextStyle(
                          color: clickIndex == 11 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 12 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 12;
                        setState(() {});
                        scrollController.animateTo( 8440.0 + 8440 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Coffee",
                        style: TextStyle(
                          color: clickIndex == 12 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      color: clickIndex == 13 ? color : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                      onPressed: () {
                        clickIndex = 13;
                        setState(() {});
                        scrollController.animateTo( 9170.0 + 9170 + 20.9,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear);
                      },
                      child: Text(
                        "Tea",
                        style: TextStyle(
                          color: clickIndex == 13 ? Colors.white : Colors
                              .black,
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child:
                RepaintBoundary(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      print(constraints);
                      double width = constraints.maxWidth <= 700
                          ? (constraints.maxWidth / 100) * 95
                          : (constraints.maxWidth / 100) * 65;
                      return Container(
                        constraints: constraints.maxWidth <= 500
                            ? BoxConstraints(maxWidth: width)
                            : BoxConstraints(maxWidth: width),
                        child: Column(
                          children: <Widget>[
                            MenuCard(
                              width: width,
                              title: 'Ramadan Special',
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[0],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            MenuCard(
                              title: 'Break Fast',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[1],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            MenuCard(
                              title: 'Soup',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[2],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            MenuCard(
                              title: 'Salad',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[3],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            MenuCard(
                              title: 'Starter',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[4],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            MenuCard(
                              title: 'Cold Starter',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[5],
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            MenuCard(
                              title: 'Bao',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[6],
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            MenuCard(
                              title: 'Main Course',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[7],
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            MenuCard(
                              title: 'Burgers And Sliders',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[8],
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            MenuCard(
                              title: 'Pasta',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[9],
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            MenuCard(
                              title: 'Desserts',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[10],
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            MenuCard(
                              title: 'Drink',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[11],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            MenuCard(
                              title: 'Coffee',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[12],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            MenuCard(
                              title: 'Tea',
                              width: width,
                              constraints: constraints.maxWidth <= 500,
                              items: items.values.toList()[13],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              ),
            )
          ],
        ),
      ),
    );
  }

  localNavigator(Widget page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => page))
        .then((value) {
      setState(() {});
    });
  }
}




class MenuCard extends StatefulWidget {
  final String title;
  final List<MenuItem> items;
  final bool constraints;
  final double width;

  const MenuCard(
      {Key key, this.title, this.items, this.constraints, this.width})
      : super(key: key);
  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title.toString(),
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 14,
          ),
          Column(
            children: widget.items
                .map(
                  (e) => Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                height: 135,
                width: media.width / 1.0,
                child: Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/details',
                          arguments: {'id': e.id, 'item': e});
                      // localNavigator(addingPage(
                      //   id: e.id,
                      //   item: e,
                      // ));  //
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              margin: EdgeInsets.only(top: 6, left: 9),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    e?.name.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.0),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      e?.description.toString(),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child:
                                    Text('BD ' + e?.price.toString(),style:TextStyle(  fontWeight: FontWeight.bold,fontSize: 14,
                                    ),),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                                alignment: Alignment.topRight,
                                height: (media.height / 100) * 17,
                                width: widget.constraints
                                    ? (media.width / 100) * 30
                                    : (media.width / 100) * 18,
                                child: Image.network(
                                  e.imageUrl,
                                  height: (media.height / 100) * 17,
                                  width: widget.constraints
                                      ? (media.width / 100) * 30  ///CheckingScrolling
                                      : (media.width / 100) * 18,
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  localNavigator(Widget page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => page))
        .then((value) {
      setState(() {});
    });
  }
}
