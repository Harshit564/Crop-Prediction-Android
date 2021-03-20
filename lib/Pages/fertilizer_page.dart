import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_prediction/Pages/fertilizer_success.dart';
import 'package:crop_prediction/Pages/value_success_page.dart';
import 'package:crop_prediction/Widgets/buttons.dart';
import 'package:crop_prediction/Widgets/value_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FertilizerPage extends StatefulWidget {
  static const String routeName = "/fertilizer-page";
  @override
  _FertilizerPageState createState() => _FertilizerPageState();
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

class _FertilizerPageState extends State<FertilizerPage> {
  final _fertilizerFormKey = GlobalKey<FormState>();
  final TextEditingController _uidInputController = TextEditingController();
  final TextEditingController _nitrogenInputController =
      TextEditingController();
  final TextEditingController _phosphorusInputController =
      TextEditingController();
  final TextEditingController _potassiumInputController =
      TextEditingController();

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
        .collection('fertilizer content')
        .document(_uidInputController.text.toString().trim())
        .setData({
      'UID': _uidInputController.text.toString().trim(),
      'nitrogen content': _nitrogenInputController.text.toString().trim(),
      'phosphorus content': _phosphorusInputController.text.toString().trim(),
      'potassium content': _potassiumInputController.text.toString().trim(),
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
            key: _fertilizerFormKey,
            child: Column(
              children: <Widget>[
                buildTextFormsField(
                  editingController: _uidInputController,
                  errorMessage: 'Please enter your uid',
                  hintText: 'UID',
                  preIcon: Icon(Icons.person),
                ),
                buildTextFormsField(
                  editingController: _nitrogenInputController,
                  errorMessage: 'Please enter nitrogen content',
                  hintText: 'Nitrogen Content',
                  preIcon: Icon(Icons.book_online),
                ),
                buildTextFormsField(
                  editingController: _phosphorusInputController,
                  errorMessage: 'Please enter phosphorus content',
                  hintText: 'Phosphorus Content',
                  preIcon: Icon(Icons.book_online),
                ),
                buildTextFormsField(
                  editingController: _potassiumInputController,
                  errorMessage: 'Please enter potassium content',
                  hintText: 'Potassium Content',
                  preIcon: Icon(Icons.book_online),
                ),
                SizedBox(
                  height: 20,
                ),
                buttons(
                  function: () {
                    enterValue();
                    Navigator.pushNamed(context, FertilizerSuccess.routeName);
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
