import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';

import '../../../common/helper/show_alert_dialog.dart';
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

  sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryCode = countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(
        context: context,
        message: "Please enter your phone number",
      );
    } else if(countryCode.isEmpty){
      return showAlertDialog(
        context: context,
        message: "Please enter your country code",
      );
    }else if (phoneNumber.length < 9) {
      return showAlertDialog(
        context: context,
        message:
            'The phone number you entered is too short!',
      );
    } else if (phoneNumber.length > 10) {
      return showAlertDialog(
        context: context,
        message:
            "The phone number you entered is too long!",
      );
    } else if (countryCode.length > 3) {
      return showAlertDialog(
        context: context,
        message:
            "The country code you entered is too long!",
      );
    }

    ref.read(authControllerProvider).signInWithPhone(context, '+$countryCode$phoneNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
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
                        "My number is",
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
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                helperText: 'Country code'),
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
                                  InputDecoration(helperText: 'Phone number'),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'When you tap "Continue", Tinder will send a text a with verification code. Message and data rates may apply.',
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
                          child: Text(
                            "CONTINUE",
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