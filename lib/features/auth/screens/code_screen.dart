import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';

class CodeScreen extends ConsumerWidget {
  static const String routeName = '/code-screen';
  final String verificationId;
  const CodeScreen({super.key, required this.verificationId});

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP){
    ref.read(authControllerProvider).vetifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Coloors.primaryColor),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("verifying_your_number".tr()),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Lottie.asset(
            'assets/lottiefiles/sms-screen-05.json',
            width: 300.w,
            height: 300.h,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 20),
          Text("we_have_sent_a_sms".tr()),
          SizedBox(
            width: size.width * 0.5,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: '------',
                hintStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value){
                if(value.length == 6){
                  verifyOTP(ref, context, value);
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}


