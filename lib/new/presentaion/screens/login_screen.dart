import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/new/presentaion/screens/phone_auth_screen.dart';

import '../../../common/utils/tinder_icons.dart';
import '../../../common/utils/coloors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';


  void navigateToPhoneAuthScreen(BuildContext context){
    Navigator.pushNamed(context, PhoneAuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Coloors.accentColor,
                        Coloors.secondaryHeaderColor,
                        Coloors.primaryColor
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.35, 1.0])),
              child: Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            TinderIcons.iconfinder_338_tinder_logo_4375488__1_,
                            color: Colors.white,
                            size: 100.sp,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "Tinder",
                            style: TextStyle(
                                fontSize: 50.sp,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          )
                        ],
                      ))),
                  Expanded(
                    flex: 2,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'by_clicking_log_in'.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                            width: double.infinity,
                            height: 45.h,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45.0),
                                  ),
                                  backgroundColor: Colors.white,
                                  elevation: 0.0,
                                ),
                                onPressed: () => navigateToPhoneAuthScreen(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "log_in_with_phone_number".tr(),
                                      style: const TextStyle(
                                          color: Colors.grey, wordSpacing: 1.2),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      
                    ]),
                  )
                ],
              )));
  }
}