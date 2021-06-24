import 'dart:async';
import 'dart:ui';

import 'package:bbqisland/cartModel.dart';
import 'package:bbqisland/http_service.dart';
import 'package:bbqisland/menu.dart';
import 'package:bbqisland/my_singleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  var dashboardClass;
  MySingleton _mySingleton = MySingleton();
  List<dynamic> categoryList = [];
  List<Menu> menuList = [];
  CartMenu cartMenu = CartMenu();
  void _incrementCart(Menu menu) {
    Provider.of<CartMenu>(context, listen: false).setCartList(menu);
  }

  @override
  void initState() {
    _getCategories().then(
        (value) => {categoryList = value, print(categoryList.toString())});
    _getMenu().then((value) => menuList = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: Image.asset('assets/images/bbqisland_only_logo.png'),
            ),
            Center(
                child: ClipRect(
                    child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 50.0,
                sigmaY: 50.0,
              ),
              child: new Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 50, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Hello Rathiesh',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 30),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    height: 100.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(categoryList[index].toString(),
                                style: TextStyle(color: Colors.white)));
                      },
                    ),
                  ),
                  Expanded(
                      child: GridView.builder(
                    itemCount: menuList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 3
                          : 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: (2 / 1),
                    ),
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                          setState(() {
                            _mySingleton.updateCartValue(menuList[index]);
                            cartMenu.setCartList(menuList[index]);
                          });
                          _incrementCart(menuList[index]);
                        },
                        child: Container(
                          color: Colors.grey.withOpacity(0.3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(menuList[index].menuName,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.yellowAccent),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
                ],
              ),
            )))
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> _getCategories() async {
  List<dynamic> categoryList = [];
  await HttpService().getCategories().then((value) =>
      {print(value.toString() + "liiisssstttt"), categoryList = value});

  return categoryList;
}

Future<List<Menu>> _getMenu() async {
  List<Menu> menuList = [];
  await HttpService()
      .getMenus()
      .then((value) => {menuList = value, print(menuList.toString())});

  return menuList;
}
