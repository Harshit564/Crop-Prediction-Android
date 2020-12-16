import 'package:crop_prediction/Pages/home_page.dart';
import 'package:crop_prediction/Widgets/buttons.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login-page";

  @override
  _LoginPageState createState() => _LoginPageState();
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

Widget formFields(
    {String errorMessage,
    String hintText,
    Icon preIcon,
    TextEditingController editingController}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Theme(
      data: new ThemeData(primaryColor: Colors.green[600]),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return errorMessage;
          }
          return null;
        },
        cursorColor: Colors.green,
        //keyboardType: TextInputType.numberWithOptions(signed: false,decimal: false),
        controller: editingController,
        decoration: InputDecoration(
          prefixIcon: preIcon,
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(30.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    ),
  );
}

class _LoginPageState extends State<LoginPage> {
  // text Editing Controllers
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _UIDInputController = TextEditingController();
  final TextEditingController _contactInputController = TextEditingController();
  final TextEditingController _addressInputController = TextEditingController();

  // proficiency
  bool isSwitched = true;

  bool isConnected = false;

  // Student Info
  String userName = "";
  String userID = "";
  String userContact = "";
  String userAddress = "";

  // Form Key of Login Page
  final _userLoginFormKey = GlobalKey<FormState>();

  // loading state
  bool isLoading = false;

  // logging state
  bool isLoggedIn = false;

  // login credentials
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser currentUser;
  SharedPreferences prefs;

  _checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showConnectionErrorDialog();
    } else {
      setState(() {
        isConnected = true;
      });
    }
  }

  _showConnectionErrorDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Internet Connecion Error',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Please check your internet connection',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Close',
                  style:
                      TextStyle(fontFamily: 'Montserrat', color: Colors.amber),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  // Checks if the user is already signed in
  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();
    String loggedUserName = prefs.get('userName');

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn && loggedUserName != null) {
      print('sadasd');
      Navigator.pushReplacementNamed(
        context,
        HomePage.routeName,
      );
    }

    this.setState(() {
      isLoading = false;
    });
  }

  // sign in function
  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    AuthResult _authResult =
        await firebaseAuth.signInWithCredential(credential);
    FirebaseUser firebaseUser = _authResult.user;

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance
            .collection('users')
            .document(_UIDInputController.text.toString().trim())
            .setData({
          'userName': _nameInputController.text.toString().trim(),
          'userID': _UIDInputController.text.toString().trim(),
          'userContact': _contactInputController.text.toString().trim(),
          'firebaseID': firebaseUser.uid,
          'userAddress': _addressInputController.text.toString().trim(),
        });

        // Write data to local
        currentUser = firebaseUser;
        await prefs.setString(
          'studentName',
          _nameInputController.text.toString().trim(),
        );
        await prefs.setString(
          'studentSID',
          _UIDInputController.text.toString().trim(),
        );
        await prefs.setString(
          'contactNumber',
          _contactInputController.text.toString().trim(),
        );
        await prefs.setString('firebaseID', currentUser.uid);
        await prefs.setString(
          'collegeName',
          _addressInputController.text.toString().trim(),
        );
      } else {
        // Write data to local
        await prefs.setString('userName', documents[0]['userName']);
        await prefs.setString('userID', documents[0]['userID']);
        await prefs.setString('userContact', documents[0]['userContact']);
        await prefs.setString('firebaseID', documents[0]['firebaseID']);
        await prefs.setString('userAddress', documents[0]['userAddress']);
      }
      this.setState(() {
        isLoading = false;
      });

      Navigator.pushReplacementNamed(
        context,
        HomePage.routeName,
      );
    } else {
      this.setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 10.0,
        ),
        children: <Widget>[
          mainLogoLoginPage('assets/logo.png'),
          Form(
            key: _userLoginFormKey,
            child: Column(
              children: <Widget>[
                formFields(
                  editingController: _nameInputController,
                  errorMessage: 'Please enter your full name',
                  hintText: 'Full Name',
                  preIcon: Icon(Icons.person),
                ),
                formFields(
                  editingController: _contactInputController,
                  errorMessage: 'Please enter your contact number',
                  hintText: 'Contact',
                  preIcon: Icon(Icons.phone),
                ),
                formFields(
                  editingController: _addressInputController,
                  errorMessage: 'Please enter your address',
                  hintText: 'Address',
                  preIcon: Icon(Icons.location_city),
                ),
                formFields(
                  editingController: _UIDInputController,
                  errorMessage: 'Please enter your UID',
                  hintText: 'UID in the range (0-9)',
                  preIcon: Icon(Icons.perm_identity),
                ),
                SizedBox(
                  height: 50.0,
                ),
                buttons(
                  function: () {
                    _checkInternetConnection();
                    if (_userLoginFormKey.currentState.validate() &&
                        isConnected) {
                      //print("Valid");
                      handleSignIn();
                    }
                  },
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.green.shade100,
                              strokeWidth: 3,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.green[900]),
                            )
                          : Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 16.0),
                            ),
                    ),
                  ),
                ),
                isLoading
                    ? Container(
                        child: Text(
                          'Please wait',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.green[900],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
