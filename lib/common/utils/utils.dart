import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';

Future<File?> pickImageFromGallery(BuildContext context) async{
  File? image;
  try{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedImage != null){
      image = File(pickedImage.path);
    }
  }catch (e){
    showAlertDialog(context: context, message: e.toString());
  }

  return image;
}

Map<String, int> convertBirthday(String date){
  return {
    'day': int.parse(date.split('.')[0]),
    'month': int.parse(date.split('.')[1]),
    'year': int.parse(date.split('.')[2]),
  };
}