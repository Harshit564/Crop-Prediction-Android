import 'package:flutter/material.dart';

Widget buildTextFormsField(
    {String errorMessage,
    String hintText,
    TextEditingController editingController,
    Icon preIcon,
    String initialValue}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Theme(
      data: new ThemeData(primaryColor: Colors.green[600]),
      child: TextFormField(
        initialValue: initialValue,
        validator: (value) {
          if (value.isEmpty) {
            return errorMessage;
          }
          return null;
        },
        cursorColor: Colors.green,
        controller: editingController,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontFamily: 'Montserrat'),
          prefixIcon: preIcon,
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    ),
  );
}
