import 'package:crop_prediction/Pages/about_page.dart';
import 'package:crop_prediction/Pages/contact_page.dart';
import 'package:crop_prediction/Pages/enter_values_page.dart';
import 'package:crop_prediction/Pages/home_page.dart';
import 'package:crop_prediction/Pages/imp_page.dart';
import 'package:crop_prediction/Pages/login_page.dart';
import 'package:crop_prediction/Pages/splash_page.dart';
import 'package:crop_prediction/Pages/value_success_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(),
      theme: ThemeData(backgroundColor: Colors.green),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        LoginPage.routeName: (context) => LoginPage(),
        AboutPage.routeName: (context) => AboutPage(),
        ContactPage.routeName: (context) => ContactPage(),
        EnterValuePage.routeName: (context) => EnterValuePage(),
        ImpPage.routeName: (context) => ImpPage(),
        ValueSuccess.routeName: (context) => ValueSuccess()
      },
    );
  }
}
