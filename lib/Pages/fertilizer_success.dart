import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_prediction/Pages/home_page.dart';
import 'package:flutter/material.dart';

class FertilizerSuccess extends StatefulWidget {
  static const String routeName = "/fsuccess-page";
  @override
  _FertilizerSuccessState createState() => _FertilizerSuccessState();
}

class _FertilizerSuccessState extends State<FertilizerSuccess> {
  final _fireStore = Firestore.instance;

  String uid = "";
  String nitrogen = "";
  String phosphorus = "";
  String potassium = "";

  int n, p, k;
  int ni, po, pk;
  int pmin, pmax, nmin, nmax, kmin, kmax;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
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
              (int.tryParse(nitrogen) == 180)
                  ? Column(
                      children: <Widget>[
                        Image.asset('assets/images/potato.jpg'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Predicted crop is POTATO')
                      ],
                    )
                  : ((int.tryParse(nitrogen) == 60)
                      ? Column(
                          children: <Widget>[
                            Image.asset('assets/logo.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Predicted crop is WHEAT')
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset('assets/images/paddy.jpg'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Predicted crop is PADDY',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Montserrat'),
                            )
                          ],
                        )),
              SizedBox(
                height: 30,
              ),
              StreamBuilder(
                stream: _fireStore.collection('fertilizer content').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final fInfo = snapshot.data.documents;
                    uid = fInfo[0].data['UID'];
                    nitrogen = fInfo[0].data['nitrogen content'];
                    phosphorus = fInfo[0].data['phosphorus content'];
                    potassium = fInfo[0].data['potassium content'];
                    ni = int.parse(nitrogen);
                    po = int.parse(phosphorus);
                    pk = int.parse(potassium);
                    n = 120;
                    p = 40;
                    k = 40;
                    nmin = n - ni;
                    nmax = ni - n;
                    pmin = p - po;
                    pmax = po - p;
                    kmin = k - pk;
                    kmax = pk - k;
                    print("hello");
                    print(n + p + k);
                  } else {
                    uid = "Unexpected Error Occurred";
                  }
                  return Column(children: <Widget>[
                    (int.parse(nitrogen) < n)
                        ? Text(
                            'Nitrogen to be added: ' + '$nmin',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Montserrat'),
                          )
                        : Text(
                            'Nitrogen excess: ' + '$nmax',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Montserrat'),
                          ),
                    SizedBox(height: 10),
                    (int.parse(phosphorus) < p)
                        ? Text(
                            'Phosphorus to be added: ' + '$pmin',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Montserrat'),
                          )
                        : Text(
                            'Phosphorus excess: ' + '$pmax',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Montserrat'),
                          ),
                    SizedBox(height: 10),
                    (int.parse(potassium) < k)
                        ? Text(
                            'Potassium to be added: ' + '$kmin',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Montserrat'),
                          )
                        : Text(
                            'Potassium excess: ' + '$pmax',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Montserrat'),
                          ),
                  ]);
                },
              ),
              SizedBox(
                height: 20,
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
          )),
    );
  }
}
