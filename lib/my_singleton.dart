import 'package:bbqisland/menu.dart';

class MySingleton {
  static final MySingleton _singleton = MySingleton._internal();
  List<Menu> cartList = [];

  get getCartList => cartList;

  void updateCartValue(Menu menu) {
    cartList.add(menu);
    print(menu.toString());
  }

  factory MySingleton() {
    return _singleton;
  }

  MySingleton._internal();
}
