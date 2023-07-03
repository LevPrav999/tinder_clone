import 'package:flutter/material.dart';
import 'package:tinder_clone/common/widgets/error.dart';
import 'package:tinder_clone/features/auth/screens/phone_auth_screen.dart';
import 'package:tinder_clone/features/auth/screens/code_screen.dart';
import 'package:tinder_clone/features/auth/screens/user_information_screen.dart';
import 'package:tinder_clone/features/login/screens/login_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case PhoneAuthScreen.routeName:
        return MaterialPageRoute(builder: (context) => const PhoneAuthScreen());
      case UserInfoScreen.routeName:
        final data = settings.arguments as Map<String, String?>?;
        return MaterialPageRoute(builder: (context) => UserInfoScreen(
          name: data?['name'] ?? "Your Name",
          age: data?['age'] ?? "01.01.2001",
          sex: data?['sex'] ?? "",
          city: data?['city'] ?? "Moscow",
          bio: data?['bio'] ?? "Hi! I am using Tinder!",
          sexFind: data?['sexFind'] ?? "",
        ));
      case CodeScreen.routeName:
        final verificationId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => CodeScreen(verificationId: verificationId));
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: ErrorScreen(error: "This page doesn't exist!S"),
                ));
    }
  }
}
