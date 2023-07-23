import 'package:flutter/material.dart';
import 'package:tinder_clone/common/utils/coloors.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}){
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              btnText ?? "OK",
              style: const TextStyle(
                color: Coloors.primaryColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}