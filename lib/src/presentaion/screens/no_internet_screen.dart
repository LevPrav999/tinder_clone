import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image(
                width: 300.w,
                height: 150.h,
                fit: BoxFit.cover,
                image: const AssetImage('assets/images/sorry.png')),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 30.w),
            child: Text("No internet connection...",
                textAlign: TextAlign.center,
                style: TextStyle(
                    wordSpacing: 1.2,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade600)),
          )
        ],
      )),);
  }
}