import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/new/presentaion/controllers/code_screen_controller.dart';

class CodeScreen extends ConsumerWidget {
  static const String routeName = '/code-screen';
  final String verificationId;
  const CodeScreen({super.key, required this.verificationId});

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP){
    ref.read(codeScreenProvider.notifier).verifyCode(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    var state = ref.watch(codeScreenProvider);

    ref.listen<AsyncValue>(
      codeScreenProvider,
      (_, state) {
        if (!state.isRefreshing && state.hasError && !state.isLoading) {
          showAlertDialog(context: context, message: state.error.toString());
        }
      },
    );

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
            const SizedBox(height: 10),
            state.isLoading ? CircularProgressIndicator() : Lottie.asset(
            'assets/lottiefiles/sms.json',
            width: 250.w,
            height: 200.h,
            fit: BoxFit.fill,
            repeat: false
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


