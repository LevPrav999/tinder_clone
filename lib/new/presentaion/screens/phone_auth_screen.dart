import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/new/presentaion/controllers/phone_login_controller.dart';

import '../../../common/utils/coloors.dart';

class PhoneAuthScreen extends ConsumerStatefulWidget {
  const PhoneAuthScreen({super.key});

  static const routeName = '/phone-auth';

  @override
  ConsumerState<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends ConsumerState<PhoneAuthScreen> {
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  @override
  void initState(){
    countryCodeController = TextEditingController();
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void sendCodeToPhone() async{
    await ref.read(phoneLoginScreenNotifierProvider.notifier).loginWithPhoneNumber(context, countryCodeController.text, phoneNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(phoneLoginScreenNotifierProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Coloors.primaryColor),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: 25.w,
            right: 25.w),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "my_number_is".tr(),
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: countryCodeController,
                            keyboardType: TextInputType.number,
                            cursorColor: Coloors.primaryColor,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                helperText: 'country_code'.tr()),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            flex: 7,
                            child: TextField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.number,
                              cursorColor: Coloors.primaryColor,
                              decoration:
                                  InputDecoration(helperText: 'phone_number'.tr()),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'when_you_tap_continue'.tr(),
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () => sendCodeToPhone(),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.0),
                            gradient: const LinearGradient(
                                colors: [
                                  Coloors.accentColor,
                                  Coloors.secondaryHeaderColor,
                                  Coloors.primaryColor
                                ],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                stops: [0.0, 0.1, 1.0])),
                        width: double.infinity,
                        height: 60,
                        child: Center(
                          child: state.isLoading ? const CircularProgressIndicator() : Text(
                            "continue".tr(),
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}