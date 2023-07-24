import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/errors/errors.dart';
import 'package:tinder_clone/new/application/auth_service.dart';

import '../screens/code_screen.dart';
import '../screens/home_screen.dart';


final phoneLoginScreenProvider = AsyncNotifierProvider<PhoneLoginScreenNotifier, String>(PhoneLoginScreenNotifier.new);


class PhoneLoginScreenNotifier extends AsyncNotifier<String>{

  @override
  FutureOr<String> build() {
    return "";
  }


  Future<void> loginWithPhoneNumber(BuildContext context, String countryCode, String phoneNumber) async{
    state = const AsyncLoading();

    final authService = ref.read(authServiceProvider);

    if (phoneNumber.isEmpty) {
      state = AsyncValue.data("please_enter_your_phone_number".tr());
    } else if(countryCode.isEmpty){
      state = AsyncValue.data("please_enter_your_country_code".tr());
    }else if (phoneNumber.length < 9) {
      state = AsyncValue.data("phone_number_short".tr());
    } else if (phoneNumber.length > 10) {
      state = AsyncValue.data("phone_number_long".tr());
    } else if (countryCode.length > 3) {
      state = AsyncValue.data("country_code_long".tr());
    }else{
      var result = await authService.signInWithPhone('+$countryCode$phoneNumber');

      result.fold((left) {
        if(left is NotAutomaticRetrieved){
          Navigator.pushNamed(context, CodeScreen.routeName,
                arguments: left.verificationId);
        }else{
          state = AsyncValue.error(left.message, StackTrace.empty);
        }
      }, (right){
        state = const AsyncValue.data("");
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
      });
    }
  }
}