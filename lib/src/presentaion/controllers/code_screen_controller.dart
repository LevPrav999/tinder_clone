import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/src/application/auth_service.dart';

import '../screens/home_screen.dart';
import '../screens/user_info_screen.dart';

final codeScreenProvider = AsyncNotifierProvider<CodeScreenNotifier, String>(CodeScreenNotifier.new);

class CodeScreenNotifier extends AsyncNotifier<String> {

  ProviderSubscription? subscription = null;

  @override
  FutureOr<String> build() {
    return "";
  }

  Future<void> verifyCode(BuildContext context, String verificationId, String smsCode) async{
    state = const AsyncLoading();

    final authService = ref.read(authServiceProvider);

    var result = await authService.verifyCode(verificationId, smsCode);

    result.fold((left){
      state = AsyncValue.error(left.message, StackTrace.empty);
    }, (right){
      state = const AsyncValue.data("");
      subscription!.close();
      if(right == true){
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(
            context,
            UserInfoScreen.routeName,
            arguments: {'fromProfile': false},
            (route) => false);
      }
    });
  }

  void setSub(ProviderSubscription subscription){
    this.subscription = subscription;
  }
}