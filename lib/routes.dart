import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tinder_clone/common/widgets/error.dart';

import 'new/domain/user_model.dart';
import 'new/presentaion/screens/chat_screen.dart';
import 'new/presentaion/screens/code_screen.dart';
import 'new/presentaion/screens/home_screen.dart';
import 'new/presentaion/screens/login_screen.dart';
import 'new/presentaion/screens/match_screen.dart';
import 'new/presentaion/screens/phone_auth_screen.dart';
import 'new/presentaion/screens/tags_screen.dart';
import 'new/presentaion/screens/user_info_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case PhoneAuthScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const PhoneAuthScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            });
      case MatchScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MatchScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            maintainState: false);
      case HomeScreen.routeName:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            maintainState: false);
      case ChatScreen.routeName:
        final user = settings.arguments as UserModel;
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChatScreen(user: user),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            maintainState: false);
      case TagsScreen.routeName:
        final tags = settings.arguments as List<dynamic>;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              TagsScreen(userTagsSelected: tags),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
              child: child,
            );
          },
        );
      case UserInfoScreen.routeName:
        final data = settings.arguments as Map<String, dynamic>?;
        if (data?['fromProfile'] == true) {
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  UserInfoScreen(
                    name: data?['name'] ?? "your_name".tr(),
                    age: data?['age'] ?? "01.01.2001",
                    sex: data?['sex'] ?? "",
                    city: data?['city'] ?? "moscow".tr(),
                    bio: data?['bio'] ?? "hi_i_am_using_tinder".tr(),
                    sexFind: data?['sexFind'] ?? "",
                    avatar: data?['avatar'] ?? "",
                    fromProfile: data?['fromProfile'] as bool,
                  ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.vertical,
                  child: child,
                );
              },
              maintainState: false);
        }
        return MaterialPageRoute(
            builder: (context) => UserInfoScreen(
                  name: data?['name'] ?? "your_name".tr(),
                  age: data?['age'] ?? "01.01.2001",
                  sex: data?['sex'] ?? "",
                  city: data?['city'] ?? "moscow".tr(),
                  bio: data?['bio'] ?? "hi_i_am_using_tinder".tr(),
                  sexFind: data?['sexFind'] ?? "",
                  avatar: data?['avatar'] ?? "",
                  fromProfile: data?['fromProfile'] as bool,
                ),
            maintainState: false);
      case CodeScreen.routeName:
        final verificationId = settings.arguments as String;
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CodeScreen(verificationId: verificationId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            });
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: ErrorScreen(error: "This page doesn't exists!"),
                ));
    }
  }
}
