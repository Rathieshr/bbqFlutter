import 'dart:ui';

import 'package:bbqisland/cartModel.dart';
import 'package:bbqisland/dashboard.dart';
import 'package:bbqisland/http_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: CartMenu(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellowAccent)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow))),
            brightness: Brightness.light,
            /* light theme settings */
          ),
          darkTheme: ThemeData(
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            ),
            brightness: Brightness.dark,
            /* dark theme settings */
          ),
          themeMode: ThemeMode.dark,
          /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
          debugShowCheckedModeBanner: false,
          home: LoginDemo(),
        ));
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                  sigmaX: 25.0,
                  sigmaY: 25.0,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: Container(
                            width: 250,
                            height: 200,
                            child:
                                Image.asset('assets/images/bbqislandlogo.png')),
                      ),
                    ),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w400),
                        controller: emailController,
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow)),
                            focusColor: Colors.yellow,
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              color: Colors.yellow,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 30),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w400),
                          controller: passController,
                          obscureText: true,
                          cursorColor: Colors.amber,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow)),
                              focusColor: Colors.yellow,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.yellow,
                              ))),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Color(0xFFffd57e),
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.yellow),
                        onPressed: () {
                          HttpService()
                              .getLogin(
                                  emailController.text, passController.text)
                              .then((value) => {
                                    if (value == true)
                                      {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    DashBoardClass()))
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Invalid Credentials. Could not log you in')))
                                      }
                                  });
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
