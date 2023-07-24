import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/application/user_service.dart';

import '../screens/home_screen.dart';
import '../screens/tags_screen.dart';

final userInfoScreenProvider = AsyncNotifierProvider<UserInfoScreenNotifier, String>(UserInfoScreenNotifier.new);

class UserInfoScreenNotifier extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() {
    return "";
  }

  bool _isDateValid(String dateStr) {
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


  Future<void> storeUserData(File? image, String name, String age, String sex, String city, String bio, String sexFind, bool fromProfile, BuildContext context) async {
    state = const AsyncLoading();
    if (name.replaceAll(" ", "").length < 3) {
      state = AsyncValue.error("name_too_short".tr(), StackTrace.empty);
    } else if (age.replaceAll(" ", "").length < 10) {
      state = AsyncValue.error("birthday_invalid_format".tr(), StackTrace.empty);
    } else if (!_isDateValid(age)) {
      state = AsyncValue.error("birthday_invalid_format".tr(), StackTrace.empty);
    } else if (city.replaceAll(" ", "").length < 3) {
      state = AsyncValue.error("town_name_short".tr(), StackTrace.empty);
    } else if (bio.trim().length < 3) {
      state = AsyncValue.error("bio_short".tr(), StackTrace.empty);
    } else if (sex == "") {
      state = AsyncValue.error("sex_isnt_set".tr(), StackTrace.empty);
    } else if (sexFind == "") {
      state = AsyncValue.error("sex_of_person_isnt_set".tr(), StackTrace.empty);
    } else {
      var result = await ref.read(userServiceProvider).saveUserData(
          name.replaceAll(" ", ""),
          age.replaceAll(" ", ""),
          sex,
          city.toLowerCase(),
          bio.trim(),
          sexFind,
          image,
          image != null && fromProfile == true);

      result.fold((left) {
        state = AsyncValue.error(left.message, StackTrace.empty);
      }, (right) {
        state = const AsyncData("");
        if(right == true){
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, TagsScreen.routeName, (route) => false,
            arguments: []);
        }
      });
    }
  }

}