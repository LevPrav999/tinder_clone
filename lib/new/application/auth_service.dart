import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/data/auth_repository.dart';
import 'package:tinder_clone/new/data/user_repository.dart';

import '../../common/repositories/common_messaging_repository.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthService(ref, authRepository);
});

class AuthService{
  AuthService(this.ref, this.authRepository);
  final Ref ref;
  final AuthRepository authRepository;


  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async{
    await authRepository.signInWithPhone(context, phoneNumber);
  }

  Future<bool> verifyCode(BuildContext context, String verificationId, String smsCode) async{
    await authRepository.verifyCode(context, verificationId, smsCode);
    return await _updateUserOrNextStep(context);
  }


  Future<bool> _updateUserOrNextStep(BuildContext context) async{
    String uid = authRepository.authUserUid!;
    bool isUserExists = await ref.read(userRepositoryProvider).isUserExists(uid);

    if(isUserExists){
      String? token = await MessagingApi().getToken();
      await ref.read(userRepositoryProvider).updateUserFcmToken(uid, token);

      return true;
    }else{
      return false;
    }
  }
}