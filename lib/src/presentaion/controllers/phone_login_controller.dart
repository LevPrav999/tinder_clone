import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/errors/errors.dart';
import 'package:tinder_clone/src/application/auth_service.dart';

import '../screens/code_screen.dart';
import '../screens/home_screen.dart';


final phoneLoginScreenProvider = AsyncNotifierProvider<PhoneLoginScreenNotifier, String>(PhoneLoginScreenNotifier.new);


class PhoneLoginScreenNotifier extends AsyncNotifier<String>{

  ProviderSubscription? subscription;

  @override
  FutureOr<String> build() {
    return "";
  }

  Future<void> loginWithPhoneNumber(BuildContext context, String countryCode, String phoneNumber) async{
    state = const AsyncLoading();

    final authService = ref.read(authServiceProvider);

    if (phoneNumber.isEmpty) {
      state = AsyncValue.error("please_enter_your_phone_number".tr(), StackTrace.empty);
    } else if(countryCode.isEmpty){
      state = AsyncValue.error("please_enter_your_country_code".tr(), StackTrace.empty);
    }else if (phoneNumber.length < 9) {
      state = AsyncValue.error("phone_number_short".tr(), StackTrace.empty);
    } else if (phoneNumber.length > 10) {
      state = AsyncValue.error("phone_number_long".tr(), StackTrace.empty);
    } else if (countryCode.length > 3) {
      state = AsyncValue.error("country_code_long".tr(), StackTrace.empty);
    }else{
      var result = await authService.signInWithPhone('+$countryCode$phoneNumber');

      result.fold((left) {
        if(left is NotAutomaticRetrieved){
          subscription!.close();
          Navigator.pushNamed(context, CodeScreen.routeName,
                arguments: left.verificationId);
        }else{
          state = AsyncValue.error(left.message, StackTrace.empty);
        }
      }, (right){
        state = const AsyncValue.data("");
        subscription!.close();
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
      });
    }
  }

  void setSub(ProviderSubscription subscription){
    this.subscription = subscription;
  }
}