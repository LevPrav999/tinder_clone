import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tinder_clone/common/utils/coloors.dart';

class DateMessageCard extends StatelessWidget {
  const DateMessageCard({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Coloors.brushPink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        DateFormat.yMMMd().format(date),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}