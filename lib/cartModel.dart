import 'package:bbqisland/menu.dart';
import 'package:flutter/material.dart';

class CartMenu extends ChangeNotifier {
  List<Menu> cartList = [];

  getCartList() => cartList;
  getCartListLength() => cartList.length;

  setCartList(Menu menu) {
    cartList.add(menu);
    notifyListeners();
  }
}
