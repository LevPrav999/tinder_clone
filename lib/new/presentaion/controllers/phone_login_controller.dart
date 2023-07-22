import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/application/auth_service.dart';

import '../../../common/helper/show_alert_dialog.dart';


final phoneLoginScreenNotifierProvider = AsyncNotifierProvider<PhoneLoginScreenNotifier, void>(PhoneLoginScreenNotifier.new);


class PhoneLoginScreenNotifier extends AsyncNotifier<void>{

  @override
  FutureOr<void> build() {}


  Future<void> loginWithPhoneNumber(BuildContext context, String countryCode, String phoneNumber) async{
    state = const AsyncLoading();

    final authService = ref.read(authServiceProvider);

    if (phoneNumber.isEmpty) {
      state = await AsyncValue.guard(showAlertDialog(
        context: context,
        message: "please_enter_your_phone_number".tr(),
      ));
    } else if(countryCode.isEmpty){
      state = await AsyncValue.guard(showAlertDialog(
        context: context,
        message: "please_enter_your_country_code".tr(),
      ));
    }else if (phoneNumber.length < 9) {
      state = await AsyncValue.guard(showAlertDialog(
        context: context,
        message:
            'phone_number_short'.tr(),
      ));
    } else if (phoneNumber.length > 10) {
      state = await AsyncValue.guard(showAlertDialog(
        context: context,
        message:
            "phone_number_long".tr(),
      ));
    } else if (countryCode.length > 3) {
      state = await AsyncValue.guard(showAlertDialog(
        context: context,
        message:
            "country_code_long".tr(),
      ));
    }else{
      state = await AsyncValue.guard(authService.signInWithPhone(context, '+$countryCode$phoneNumber') as Future<void> Function());
    }
  }
}