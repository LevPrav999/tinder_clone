import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Decorations{
  static var kTextFieldDecoration = InputDecoration(
    hintText: 'enter_here'.tr(),
    hintStyle: const TextStyle(fontSize: 22),
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    fillColor: const Color.fromARGB(255, 230, 232, 243),
    filled: true,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 230, 232, 243), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 230, 232, 243), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  );

  static var kTextFieldMessageDecoration = InputDecoration(
    hintText: 'message'.tr(),
    hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF737373)),
    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    fillColor: const Color(0xFFF1F2F6),
    filled: true,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFF1F2F6), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFF1F2F6), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  );
}