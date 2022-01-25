import 'package:hambal/model/food.dart';

class FoodCart {
  static List<Food> items = [];

  additem(Food food) {
    items.add(food);
  }

  removeItem(Food food) {
    items.removeWhere((element) => element.id == food.id);
  }
}
