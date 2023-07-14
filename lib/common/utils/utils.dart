import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showAlertDialog(context: context, message: e.toString());
  }

  return image;
}

Map<String, int> convertBirthday(String date) {
  return {
    'day': int.parse(date.split('.')[0]),
    'month': int.parse(date.split('.')[1]),
    'year': int.parse(date.split('.')[2]),
  };
}

String getAge(int birthYear) {
  int currentYear = DateTime.now().year;
  int age = currentYear - birthYear;
  
  DateTime currentDate = DateTime.now();
  DateTime birthDate = DateTime(birthYear);
  if (currentDate.isBefore(DateTime(currentYear, birthDate.month, birthDate.day))) {
    age--;
  }
  
  return age.toString();
}

String lastSeenMessage(lastSeen) {
  DateTime now = DateTime.now();
  Duration differenceDuration = now.difference(
    DateTime.fromMillisecondsSinceEpoch(lastSeen),
  );

  String finalMessage = differenceDuration.inSeconds > 59
      ? differenceDuration.inMinutes > 59
          ? differenceDuration.inHours > 23
              ? "${differenceDuration.inDays} ${differenceDuration.inDays == 1 ? 'day'.tr() : 'days'.tr()}"
              : "${differenceDuration.inHours} ${differenceDuration.inHours == 1 ? 'hour'.tr() : 'hours'.tr()}"
          : "${differenceDuration.inMinutes} ${differenceDuration.inMinutes == 1 ? 'minute'.tr() : 'minutes'.tr()}"
      : 'few moments';

  return finalMessage;
}

List<List<String>> splitListIntoSubsets(List<String> list, int subsetSize) {
  List<List<String>> subsets = [];
  for (var i = 0; i < list.length; i += subsetSize) {
    subsets.add(list.sublist(
        i, i + subsetSize > list.length ? list.length : i + subsetSize));
  }
  return subsets;
}
