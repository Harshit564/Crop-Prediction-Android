import 'package:flutter/material.dart';

Widget CardTile(
    {@required String buttonName,
    @required String imageUrl,
    @required Function function,
    @required BuildContext context}) {
  return GestureDetector(
    onTap: function,
    child: Card(
      color: Colors.green.shade100,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, left: 8.0, right: 8.0, bottom: 8.0),
        child: Column(
          children: [
            Image.asset(imageUrl),
            SizedBox(height: 10),
            Text(
              buttonName,
              style: TextStyle(fontFamily: 'Montserrat'),
            )
          ],
        ),
      ),
    ),
  );
}
