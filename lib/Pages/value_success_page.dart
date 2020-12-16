import 'package:crop_prediction/Pages/home_page.dart';
import 'package:flutter/material.dart';

class ValueSuccess extends StatefulWidget {
  static const String routeName = "/success-page";
  @override
  _ValueSuccessState createState() => _ValueSuccessState();
}

class _ValueSuccessState extends State<ValueSuccess> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/logo.png",
              height: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "Values are added to dB",
              style: Theme.of(context).textTheme.title.copyWith(
                  color: Colors.black, fontSize: 20, fontFamily: 'Montserrat'),
            )),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              color: Colors.green,
              textColor: Colors.white,
              child: Text("Back to Home".toUpperCase(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Montserrat')),
            ),
          ],
        ));
  }
}
