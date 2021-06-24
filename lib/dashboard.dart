import 'dart:ui';

import 'package:bbqisland/cart.dart';
import 'package:bbqisland/cartModel.dart';
import 'package:bbqisland/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardClass extends StatefulWidget {
  @override
  _DashBoardClass createState() => _DashBoardClass();
}

class _DashBoardClass extends State<DashBoardClass> with ChangeNotifier {
  int _currentIndex = 0;
  final List<Widget> _pageOptions = [HomeApp(), CartClass()];
  @override
  Widget build(BuildContext context) {
    int _cartCount = Provider.of<CartMenu>(context).getCartListLength();

    return Scaffold(
      backgroundColor: Colors.black54,
      body: _pageOptions[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: Colors.yellowAccent),
        onTap: onTabTapped,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          new BottomNavigationBarItem(
            icon: new Stack(
              children: <Widget>[
                new Icon(Icons.shopping_cart_outlined),
                new Positioned(
                  right: 0,
                  child: new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: new Text(
                      '$_cartCount',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            label: 'Cart',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_outlined),
            label: 'Admin',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
