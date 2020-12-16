import 'package:flutter/material.dart';

void showDialogPopUp(String msg, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeInCubic,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
              height: 100,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.green[600], Colors.green.shade100]),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                msg,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.black),
              ))),
        );
      });
}
