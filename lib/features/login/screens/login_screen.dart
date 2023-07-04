import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/tinder_icons.dart';
import '../../../common/utils/coloors.dart';
import '../../auth/screens/phone_auth_screen.dart';

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
                      flex: 5,
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
                    flex: 3,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: const Text(
                          'By clicking "Log in",you agree with our Terms.\n Learn how we process your data in our Privacy  Policy and Cookies Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 50),
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
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "LOG IN WITH PHONE NUMBER",
                                      style: TextStyle(
                                          color: Colors.grey, wordSpacing: 1.2),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      const SizedBox(height: 10),
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
                                onPressed: () {
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "LOG IN WITH GOOGLE",
                                      style: TextStyle(
                                          color: Colors.grey, wordSpacing: 1.2),
                                    ),
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
