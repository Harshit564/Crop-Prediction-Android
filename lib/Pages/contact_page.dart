import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  static const String routeName = "/contact-page";
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffCBE7EA),
        centerTitle: true,
        title: Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }
}
