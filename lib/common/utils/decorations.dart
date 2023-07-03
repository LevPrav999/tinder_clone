import 'package:flutter/material.dart';

class Decorations{
  static const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter Here',
    hintStyle: TextStyle(fontSize: 22),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    fillColor: Color.fromARGB(255, 230, 232, 243),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 230, 232, 243), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 230, 232, 243), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  );
}