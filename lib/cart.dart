import 'dart:ui';

import 'package:bbqisland/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'cartModel.dart';

class CartClass extends StatefulWidget {
  @override
  _CartClass createState() => _CartClass();
}

class _CartClass extends State<CartClass> {
  CartMenu cartMenu = CartMenu();
  @override
  Widget build(BuildContext context) {
    List<Menu> cartMenuList = Provider.of<CartMenu>(context).getCartList();
    print(cartMenuList.toString());
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                child: Image.asset('assets/images/bbqisland_only_logo.png'),
              ),
              Center(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 25.0,
                      sigmaY: 25.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 30),
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Cart',
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 30)),
                                Text(
                                    '₹ ' +
                                        getTotalCartValue(cartMenuList)
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 30)),
                              ],
                            )),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.transparent,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: cartMenuList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = cartMenuList[index].menuName;
                              return Dismissible(
                                  direction: DismissDirection.endToStart,
                                  key: Key(item),
                                  onDismissed: (direction) {
                                    // Removes that item the list on swipwe
                                    setState(() {
                                      cartMenuList.removeAt(index);
                                    });
                                    // Shows the information on Snackbar
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("$item dismissed")));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, bottom: 10.0),
                                    color: Colors.grey.withOpacity(0.3),
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(cartMenuList[index].menuName,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.yellowAccent),
                                            textAlign: TextAlign.left),
                                        Text(
                                            '₹ ' +
                                                cartMenuList[index]
                                                    .price
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.redAccent),
                                            textAlign: TextAlign.right),
                                      ],
                                    ),
                                  ));

                              // return Container(
                              //   margin: const EdgeInsets.only(
                              //       left: 20.0, right: 20.0, bottom: 10.0),
                              //   color: Colors.black.withOpacity(0.5),
                              //   padding: EdgeInsets.all(20),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceEvenly,
                              //     children: [
                              //       Text(cartMenuList[index].menuName,
                              //           style: TextStyle(
                              //               fontSize: 18,
                              //               color: Colors.yellowAccent),
                              //           textAlign: TextAlign.left),
                              //       Text(cartMenuList[index].price.toString(),
                              //           style: TextStyle(
                              //               fontSize: 18,
                              //               color: Colors.redAccent),
                              //           textAlign: TextAlign.right),
                              //     ],
                              //   ),
                              // );
                            },
                          ),
                        ),
                        Material(
                          //Wrap with Material
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          elevation: 18.0,
                          color: Colors.amber,
                          clipBehavior: Clip.antiAlias, // Add This
                          child: MaterialButton(
                            padding: EdgeInsets.all(10),
                            minWidth: 200.0,
                            height: 35,
                            color: Colors.amber,
                            child: new Text('Place Order',
                                style: new TextStyle(
                                    fontSize: 16.0, color: Colors.white)),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  int getTotalCartValue(List<Menu> cartvalue) {
    var totalAmount = 0;
    for (var order in cartvalue) {
      totalAmount = totalAmount + order.price;
    }
    return totalAmount;
  }
}
