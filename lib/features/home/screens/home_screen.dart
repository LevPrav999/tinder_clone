import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';
import 'package:tinder_clone/common/states/message_state.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/common/utils/tinder_icons.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';
import 'package:tinder_clone/features/home/controller/home_controller.dart';
import 'package:tinder_clone/features/home/screens/cards_tab_screen.dart';
import 'package:tinder_clone/features/home/screens/chats_tab_screen.dart';
import 'package:tinder_clone/features/home/screens/profile_tab_screen.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver{

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch(state){
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserStatus(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserStatus(false);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(authControllerProvider).setUserStatus(true);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var index = ref.watch(homeControllerProvider);

        final lastMessage = ref.watch(messageProvider);

    if (lastMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(!(lastMessage.notification!.title!.contains("сообщение") || lastMessage.notification!.title!.contains("message"))) {
          showAlertDialog(context: context, message: "${lastMessage.notification!.title!}\n\n${lastMessage.notification!.body!}");
        }
        ref.read(messageProvider.notifier).setMessage(null);
      });
    }

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
                _buildTab(
                index: 0,
                icon: TinderIcons.iconfinder_icons_user2_1564535,
              ),
              _buildTab(
                index: 1,
                icon: TinderIcons.iconfinder_338_tinder_logo_4375488__1_,
              ),
              _buildTab(
                index: 2,
                icon: TinderIcons.iconfinder_message_01_186393,
              ),
              ],
              onTap: (index){
                ref.read(homeControllerProvider.notifier).updateState(index);
              },
            ),
          ),
          body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _buildTabBarView(index),
        ),
      ),
    );
  }

  Widget _buildTabBarView(int index) {
    switch (index) {
      case 0:
        return ProfileTabScreen();
      case 1:
        return CardsTabScreen();
      case 2:
        return ChatsTabScreen();
      default:
        return Container();
    }
  }

  Widget _buildTab({
    required int index,
    required IconData icon
  }) {
    final isSelected = index == ref.read(homeControllerProvider);

    return SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 37.w),
          child: Center(
            child: Icon(
              icon,
              color: isSelected ? Coloors.primaryColor : Colors.grey,
              size: isSelected ? 40.sp : 35.sp,
            ),
          ),
        ),
      );
  }
}