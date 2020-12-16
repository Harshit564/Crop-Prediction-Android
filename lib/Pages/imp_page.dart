import 'package:flutter/material.dart';

class ImpPage extends StatefulWidget {
  static const String routeName = "/imp-page";
  @override
  _ImpPageState createState() => _ImpPageState();
}

class _ImpPageState extends State<ImpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffCBE7EA),
        centerTitle: true,
        title: Text(
          'Important',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }
}
