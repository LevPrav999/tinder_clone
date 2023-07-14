import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';
import 'package:tinder_clone/common/utils/utils.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';

import '../../../common/utils/coloors.dart';
import '../../../common/utils/decorations.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static const routeName = '/user-information';

  final String name;
  final String age;
  final String sex;
  final String city;
  final String bio;
  final String sexFind;
  final String avatar;
  final bool fromProfile;

  const UserInfoScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.sex,
      required this.city,
      required this.bio,
      required this.sexFind,
      required this.avatar,
      required this.fromProfile
      });

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController cityController;
  late TextEditingController bioController;

  late String sex;
  late String sexFind;

  File? image;

  late String avatarUrl;

  bool isDateValid(String dateStr) {
    final parts = dateStr.split('.');

    if (parts.length != 3) {
      return false;
    }

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return false;
    }

    if (day <= 0 || day > 31 || month <= 0 || month > 12) {
      return false;
    }

    final currentDate = DateTime.now();
    final inputDate = DateTime(year, month, day);

    if (inputDate.isAfter(currentDate)) {
      return false;
    }

    return true;
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    if (nameController.text.replaceAll(" ", "").length < 3) {
      showAlertDialog(context: context, message: "name_too_short".tr());
    } else if (ageController.text.replaceAll(" ", "").length < 10) {
      showAlertDialog(context: context, message: "birthday_invalid_format".tr());
    } else if (!isDateValid(ageController.text)) {
      showAlertDialog(context: context, message: "birthday_invalid_format".tr());
    } else if (cityController.text.replaceAll(" ", "").length < 3) {
      showAlertDialog(
          context: context, message: "town_name_short".tr());
    } else if (bioController.text.trim().length < 3) {
      showAlertDialog(context: context, message: "bio_short".tr());
    } else if (sex == "") {
      showAlertDialog(context: context, message: "sex_isnt_set".tr());
    } else if (sexFind == "") {
      showAlertDialog(
          context: context,
          message: "sex_of_person_isnt_set".tr());
    } else {
      ref.read(authControllerProvider).saveDataToFirestore(
          nameController.text.replaceAll(" ", ""),
          ageController.text.replaceAll(" ", ""),
          sex,
          cityController.text.toLowerCase(),
          bioController.text.trim(),
          sexFind,
          image,
          image != null && widget.fromProfile == true,
          context);
    }
  }

  String capitalizeWords(String input) {
  List<String> words = input.split(' ');

  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    if (word.isNotEmpty) {
      words[i] = word[0].toUpperCase() + word.substring(1);
    }
  }

  return words.join(' ');
}

String addLeadingZero(String input) {
  List<String> parts = input.split('.');
  List<String> formattedParts = [];

  for (String part in parts) {
    if (part.length == 1) {
      formattedParts.add('0$part');
    } else {
      formattedParts.add(part);
    }
  }

  return formattedParts.join('.');
}

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: addLeadingZero(widget.age));
    cityController = TextEditingController(text: capitalizeWords(widget.city));
    bioController = TextEditingController(text: widget.bio);
    sex = widget.sex;
    sexFind = widget.sexFind;
    avatarUrl = widget.avatar;

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    cityController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10.h),
        color: Colors.grey.shade100,
        child: Column(children: [
          Text(
            "edit_account_data".tr(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
          image == null && avatarUrl == ""
              ? Container(
                  margin: EdgeInsets.only(top: 22.h),
                  child: GestureDetector(
                      onTap: () => selectImage(),
                      child: const CircleAvatar(
                        foregroundImage: NetworkImage(
                            "https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png"),
                        radius: 70,
                      )))
              : image != null
                  ? Container(
                      margin: EdgeInsets.only(top: 22.h),
                      child: GestureDetector(
                          onTap: () => selectImage(),
                          child: CircleAvatar(
                            foregroundImage: FileImage(image!),
                            radius: 70,
                          )))
                  : Container(
                      margin: EdgeInsets.only(top: 22.h),
                      child: GestureDetector(
                          onTap: () => selectImage(),
                          child: CircleAvatar(
                            foregroundImage: NetworkImage(avatarUrl),
                            radius: 70,
                          ))),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Column(children: [
              Text("your_real_name".tr(),
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(
                height: 2,
              ),
              TextFormField(
                maxLength: 10,
                controller: nameController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
                decoration:
                    Decorations.kTextFieldDecoration.copyWith(hintText: "name".tr()),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Column(children: [
              Text("your_birthday".tr(),
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(
                height: 2,
              ),
              TextFormField(
                maxLength: 10,
                controller: ageController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
                decoration: Decorations.kTextFieldDecoration
                    .copyWith(hintText: "birthday".tr()),
              ),
            ]),
          ),
          Padding(
              padding:
                  const EdgeInsets.only(top: 14.0, left: 16.0, right: 16.0),
              child: Column(
                children: [
                  Text("your_sex".tr(),
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(
                height: 2,
              ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            sex = "male";
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                sex == "female"
                                    ? Colors.grey
                                    : Coloors.accentColor)),
                        child: Text("male".tr()),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              sex = "female";
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  sex == "male"
                                      ? Colors.grey
                                      : Coloors.accentColor)),
                          child: Text("female".tr())),
                    ],
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Column(children: [
              Text("your_town".tr(),
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(
                height: 2,
              ),
              TextFormField(
                maxLength: 10,
                controller: cityController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
                decoration:
                    Decorations.kTextFieldDecoration.copyWith(hintText: "town".tr()),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Column(children: [
              Text("your_bio".tr(),
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(
                height: 2,
              ),
              TextFormField(
                maxLength: 22,
                controller: bioController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22.0, color: Colors.black),
                decoration:
                    Decorations.kTextFieldDecoration.copyWith(hintText: "bio".tr()),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0, left: 16.0, right: 16.0),
            child: Column(children: [
              Text("you_want_to_find".tr(),
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sexFind = "male";
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            sexFind == "female"
                                ? Colors.grey
                                : Coloors.accentColor)),
                    child: Text(
                      "male".tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sexFind = "female";
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            sexFind == "male"
                                ? Colors.grey
                                : Coloors.accentColor)),
                    child: Text("female".tr()),
                  ),
                ],
              )
            ]),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Coloors.primaryColor,
                    child: IconButton(
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: () => storeUserData(),
                    ),
                  ),
                ],
              )),
        ]),
      ),
    )));
  }
}
