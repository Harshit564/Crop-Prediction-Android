import 'package:crop_prediction/Pages/about_page.dart';
import 'package:crop_prediction/Pages/fertilizer_page.dart';
import 'package:crop_prediction/Pages/enter_values_page.dart';
import 'package:crop_prediction/Pages/imp_page.dart';
import 'package:crop_prediction/Widgets/card_widget.dart';
import 'package:crop_prediction/Widgets/popUp.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home-page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        centerTitle: true,
        shape: RoundedRectangleBorder(
            //borderRadius: BorderRadius.circular(20.0)
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100.0),
                bottomRight: Radius.circular(100.0))),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(170.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                      top: 0, right: 10, left: 10, bottom: 10),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 175,
                    height: 175,
                  )),
              Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.green,
                          offset: Offset(5.0, 5.0),
                          spreadRadius: 3)
                    ]),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Crop Prediction",
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Montserrat',
                            fontSize: 20),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 50.0, left: 8.0, right: 8.0, bottom: 8.0),
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                CardTile(
                    buttonName: 'CROP VALUES',
                    imageUrl: 'assets/logo.png',
                    function: () => {
                          Navigator.pushNamed(context, EnterValuePage.routeName)
                        },
                    context: context),
                CardTile(
                    buttonName: 'ABOUT',
                    imageUrl: 'assets/logo.png',
                    function: () =>
                        {Navigator.pushNamed(context, AboutPage.routeName)},
                    context: context),
                CardTile(
                    buttonName: 'FERTILIZER VALUES',
                    imageUrl: 'assets/logo.png',
                    function: () => {
                          Navigator.pushNamed(context, FertilizerPage.routeName)
                        },
                    context: context),
                CardTile(
                    buttonName: 'IMPORTANT',
                    imageUrl: 'assets/logo.png',
                    function: () => showDialogPopUp("COMING SOON", context)
                    /*{Navigator.pushNamed(context, ImpPage.routeName)}*/,
                    context: context),
              ],
            ),
          )),
    );
  }
}
