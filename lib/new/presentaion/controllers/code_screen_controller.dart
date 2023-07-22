import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/application/auth_service.dart';

final codeScreenProvider = AsyncNotifierProvider<CodeScreenNotifier, bool>(CodeScreenNotifier.new);

class CodeScreenNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> verifyCode(BuildContext context, String verificationId, String smsCode) async{
    state = const AsyncLoading();

    final authService = ref.read(authServiceProvider);

    state = await AsyncValue.guard(authService.verifyCode(context, verificationId, smsCode) as Future<bool> Function());

    if(state.value == true){
            Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
    }else{
        Navigator.pushNamedAndRemoveUntil(
            context,
            UserInfoScreen.routeName,
            arguments: {'fromProfile': false},
            (route) => false);
    }
  }
}