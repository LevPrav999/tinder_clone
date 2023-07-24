import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tinder_clone/common/helper/extensions.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/new/presentaion/controllers/code_screen_controller.dart';

class CodeScreen extends ConsumerStatefulWidget {

  static const String routeName = '/code-screen';
  final String verificationId;
  const CodeScreen({super.key, required this.verificationId});

  @override
  ConsumerState<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends ConsumerState<CodeScreen> {

  late ProviderSubscription subscription;

  @override
  void initState() {
    super.initState();

    subscription = ref.listenManual<AsyncValue>(
      codeScreenProvider,
      (_, state) => state.showDialogOnError(context)
    );

    ref.read(codeScreenProvider.notifier).setSub(subscription);
  }

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP){
    ref.read(codeScreenProvider.notifier).verifyCode(context, widget.verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var state = ref.watch(codeScreenProvider);

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
            state.isLoading ? const CircularProgressIndicator() : Lottie.asset(
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