import 'package:flutter/material.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/common/widgets/error.dart';
import 'package:tinder_clone/features/auth/screens/phone_auth_screen.dart';
import 'package:tinder_clone/features/auth/screens/code_screen.dart';
import 'package:tinder_clone/features/auth/screens/user_information_screen.dart';
import 'package:tinder_clone/features/chat/screens/chat_screen.dart';
import 'package:tinder_clone/features/home/screens/home_screen.dart';
import 'package:tinder_clone/features/login/screens/login_screen.dart';
import 'package:tinder_clone/features/matchers/screens/match_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case PhoneAuthScreen.routeName:
        return MaterialPageRoute(builder: (context) => const PhoneAuthScreen());
      case MatchScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const MatchScreen(), maintainState: false);
      case HomeScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => const HomeScreen(), maintainState: false);
      case ChatScreen.routeName:
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (context) => ChatScreen(user: user));
      case UserInfoScreen.routeName:
        final data = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (context) => UserInfoScreen(
                  name: data?['name'] ?? "Your Name",
                  age: data?['age'] ?? "01.01.2001",
                  sex: data?['sex'] ?? "",
                  city: data?['city'] ?? "Moscow",
                  bio: data?['bio'] ?? "Hi! I am using Tinder!",
                  sexFind: data?['sexFind'] ?? "",
                  avatar: data?['avatar'] ?? "",
                  fromProfile: data?['fromProfile'] as bool,
                ),
            maintainState: false);
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
