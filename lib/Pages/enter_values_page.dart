import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_prediction/Pages/home_page.dart';
import 'package:crop_prediction/Pages/value_success_page.dart';
import 'package:crop_prediction/Widgets/buttons.dart';
import 'package:crop_prediction/Widgets/value_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EnterValuePage extends StatefulWidget {
  static const String routeName = "/values-page";
  @override
  _EnterValuePageState createState() => _EnterValuePageState();
}

Widget mainLogoLoginPage(String imagePath) {
  return Padding(
    padding: EdgeInsets.all(30.0),
    child: Container(
      height: 100.0,
      width: 100.0,
      child: Hero(
        tag: 'logo',
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

class _EnterValuePageState extends State<EnterValuePage> {
  final _studentLoginFormKey = GlobalKey<FormState>();
  final TextEditingController _uidInputController = TextEditingController();
  final TextEditingController _phInputController = TextEditingController();
  final TextEditingController _humidityInputController =
      TextEditingController();
  final TextEditingController _moistureInputController =
      TextEditingController();
  final TextEditingController _tempInputController = TextEditingController();

  FirebaseUser currentUser;
  final _dbRef = Firestore.instance;
  DocumentSnapshot userSnap;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  void initState() {
    super.initState();
    _getUserDetails();
  }

  void _getUserDetails() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    userSnap =
        await Firestore.instance.collection("users").document(user.uid).get();
    currentUser = user;
  }

  enterValue() {
    _dbRef
        .collection('crop details')
        .document(_uidInputController.text.toString().trim())
        .setData({
      'UID': _uidInputController.text.toString().trim(),
      'pH value': _phInputController.text.toString().trim(),
      'humidity value': _humidityInputController.text.toString().trim(),
      'moisture value': _moistureInputController.text.toString().trim(),
      'temp value': _tempInputController.text.toString().trim()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.green.shade100,
        centerTitle: true,
        title: Text(
          'Enter Values',
          style: TextStyle(
              color: Colors.black, fontSize: 22.0, fontFamily: 'Montserrat'),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 1.0,
          horizontal: 10.0,
        ),
        children: <Widget>[
          mainLogoLoginPage('assets/logo.png'),
          Form(
            key: _studentLoginFormKey,
            child: Column(
              children: <Widget>[
                buildTextFormsField(
                  editingController: _uidInputController,
                  errorMessage: 'Please enter your uid',
                  hintText: 'UID',
                  preIcon: Icon(Icons.person),
                ),
                buildTextFormsField(
                  editingController: _phInputController,
                  errorMessage: 'Please enter your pH value',
                  hintText: 'pH Value',
                  preIcon: Icon(Icons.book_online),
                ),
                buildTextFormsField(
                  editingController: _humidityInputController,
                  errorMessage: 'Please enter your humidity value',
                  hintText: 'Humidity Value',
                  preIcon: Icon(Icons.book_online),
                ),
                buildTextFormsField(
                  editingController: _moistureInputController,
                  errorMessage: 'Please enter your moisture value',
                  hintText: 'Moisture Value',
                  preIcon: Icon(Icons.book_online),
                ),
                buildTextFormsField(
                  editingController: _tempInputController,
                  errorMessage: 'Please enter your temperatur value',
                  hintText: 'Temperature Value',
                  preIcon: Icon(Icons.book_online),
                ),
                SizedBox(
                  height: 20,
                ),
                buttons(
                  function: () {
                    enterValue();
                    Navigator.pushNamed(context, ValueSuccess.routeName);
                  },
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
