import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/common/utils/tinder_icons.dart';
import 'package:tinder_clone/features/home/controller/home_controller.dart';
import 'package:tinder_clone/features/home/screens/cards_tab_screen.dart';
import 'package:tinder_clone/features/home/screens/profile_tab_screen.dart';

class HomeScreen extends ConsumerWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var index = ref.watch(homeControllerProvider);

    return DefaultTabController(
      length: 3,
      initialIndex: index,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 1,
            title: TabBar(
              indicatorColor: Colors.transparent,
              tabs: [
                SafeArea(
                  child: Container(
                    padding:
                        EdgeInsets.only(bottom: 37.w),
                    child: Center(
                      child: Icon(
                        TinderIcons.iconfinder_icons_user2_1564535,
                        color: index == 0
                            ? Coloors.primaryColor
                            : Colors.grey,
                        size: 35.sp,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding:
                        EdgeInsets.only(bottom: 37.w),
                    child: Center(
                      child: Icon(
                        TinderIcons.iconfinder_338_tinder_logo_4375488__1_,
                        color: index == 1
                            ? Coloors.primaryColor
                            : Colors.grey,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding:
                        EdgeInsets.only(bottom: 37.w),
                    child: Center(
                      child: Icon(
                        TinderIcons.iconfinder_message_01_186393,
                        color: index == 2
                            ? Coloors.primaryColor
                            : Colors.grey,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
              ],
              onTap: (index) {
                ref.read(homeControllerProvider.notifier).updateState(index);
              },
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ProfileTabScreen(),
              CardsTabScreen(),
              ProfileTabScreen(),
            ],
          )),
    );
  }
}