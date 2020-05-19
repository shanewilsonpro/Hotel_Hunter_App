import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_hunter_app/Models/AppConstants.dart';
import 'package:hotel_hunter_app/Screens/login_page.dart';
import 'package:hotel_hunter_app/Screens/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        SignupPage.routeName: (context) => SignupPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, LoginPage.routeName);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.hotel,
              size: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text('Welcome to ${AppConstants.appName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
