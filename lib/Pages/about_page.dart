import 'package:crop_prediction/Pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutPage extends StatefulWidget {
  static const String routeName = "/about-page";
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool isLoading = false;
  SharedPreferences preferences;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });
  }

  Widget _buildContactGridTile({
    String imagePath,
    String name,
    String position,
    String email,
    String contact,
  }) {
    return GridTile(
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150.0,
              width: 150.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 30.0,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    email,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    contact,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.green.shade100,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.black,
            onPressed: () {
              handleSignOut().then((val) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (e) => false);
                //Navigator.pushNamed(context, LoginPage.routeName);
              });
            },
          )
        ],
        title: Text(
          'About Us',
          style: TextStyle(
              color: Colors.black, fontSize: 22.0, fontFamily: 'Montserrat'),
        ),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            _buildContactGridTile(
              contact: "7007108095",
              email: "harshitsingh.be18ele@pec.edu.in",
              imagePath: "assets/images/harshit.png",
              name: "Harshit Singh",
              position: "Frontend and Backend Developer",
            ),
            Divider(
              thickness: 2,
              color: Colors.green,
            ),
            _buildContactGridTile(
              contact: "9814378442",
              email: "nikhilaggarwal.be18ele@pec.edu.in",
              imagePath: "assets/images/nikhil.jpg",
              name: "Nikhil Aggarwal",
              position: "Frontend and Backend Developer",
            ),
            Divider(
              thickness: 2,
              color: Colors.green,
            ),
            _buildContactGridTile(
              contact: "9929589316",
              email: "monitgalav.be18ele@pec.edu.in",
              imagePath: "assets/images/monit.jpg",
              name: "Monit Galav",
              position: "Frontend Developer",
            ),
            Divider(
              thickness: 2,
              color: Colors.green,
            ),
            _buildContactGridTile(
              contact: "8890638456",
              email: "raghavgupta.be18ele@pec.edu.in",
              imagePath: "assets/images/raghav.jpg",
              name: "Raghav Gupta",
              position: "Frontend Developer",
            ),
            Divider(
              thickness: 2,
              color: Colors.green,
            ),
            _buildContactGridTile(
              contact: "8808022864",
              email: "shivamupadhyay.be18ele@pec.edu.in",
              imagePath: "assets/images/shivam.jpeg",
              name: "Shivam Upadhyay",
              position: "Frontend Developer",
            ),
          ],
        ),
      ),
    );
  }
}
