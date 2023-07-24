import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/src/presentaion/controllers/match_screen_controller.dart';
import 'package:tinder_clone/src/presentaion/controllers/tabs/cards_tab_controller.dart';
import 'package:tinder_clone/src/presentaion/controllers/tabs/chats_tab_controller.dart';

import '../../src/presentaion/states/cards_state.dart';
import '../repositories/common_messaging_repository.dart';


class CardsWidget extends ConsumerStatefulWidget {
  final bool matchScreen;
  const CardsWidget({super.key, required this.matchScreen});

  @override
  ConsumerState<CardsWidget> createState() => _CardsWidgetState();
}

class _CardsWidgetState extends ConsumerState<CardsWidget> {

  late CardSwiperController cardController;

  @override
  void initState() {
    cardController = CardSwiperController();
    super.initState();
  }

  void sendTextMessage(BuildContext context, String uid) async {
      ref.read(chatProvider.notifier).sendTextMessage("👋", uid);
  }

  @override
  Widget build(BuildContext context) {
    late CardsState? data;
    late var provider;

    if(widget.matchScreen){
      provider = ref.read(matchProvider.notifier);
      data = ref.watch(matchProvider).value;
    }else{
      provider = ref.read(cardsTabProvider.notifier);
      data = ref.watch(cardsTabProvider).value;
    }

    if (data!.cards.isEmpty) {
      provider.setCards();
      return Column(
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
            child: Text("there_is_no_one_around_you".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    wordSpacing: 1.2,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade600)),
          )
        ],
      );
    }
    
    return Stack(
    children: <Widget>[
      Positioned(
        bottom: -13.0,
        child: Container(
          height: 110.w,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  onTap: () => cardController.swipeLeft(),
                  child: Container(
                    padding: EdgeInsets.all(10.sp),
                    height: 55.h,
                    width: 56.h,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.0, 0.0), color: Colors.grey),
                          BoxShadow(
                              offset: Offset(1.0, 1.0),
                              color: Colors.grey,
                              blurRadius: 5.0),
                          BoxShadow(
                              offset: Offset(-1.0, -1.0),
                              color: Colors.white,
                              blurRadius: 10.0)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60.0)),
                    child: ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                              colors: [
                                Coloors.accentColor,
                                Coloors.primaryColor
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: const [0.0, 1.0]).createShader(bounds);
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 40.h,
                        )),
                  )),
              GestureDetector(
                  onTap: () => cardController.undo(),
                  child: Container(
                    padding: EdgeInsets.all(7.w),
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.0, 0.0), color: Colors.grey),
                          BoxShadow(
                              offset: Offset(1.0, 1.0),
                              color: Colors.grey,
                              blurRadius: 5.0),
                          BoxShadow(
                              offset: Offset(-1.0, -1.0),
                              color: Colors.white,
                              blurRadius: 10.0)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60.0)),
                    child: ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                              colors: [
                                Colors.amber.shade700,
                                Colors.amber.shade400
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: const [0.0, 1.0]).createShader(bounds);
                        },
                        child:
                            const Image(image: AssetImage('assets/images/round.png'))),
                  )),
              GestureDetector(
                  onTap: () => cardController.swipeRight(),
                  child: Container(
                    padding: EdgeInsets.all(15.sp),
                    height: 55.h,
                    width: 56.h,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.0, 0.0), color: Colors.grey),
                          BoxShadow(
                              offset: Offset(1.0, 1.0),
                              color: Colors.grey,
                              blurRadius: 5.0),
                          BoxShadow(
                              offset: Offset(-1.0, -1.0),
                              color: Colors.white,
                              blurRadius: 10.0)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60.0)),
                    child: ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                              colors: [
                                Colors.tealAccent.shade700,
                                Colors.tealAccent.shade200
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: const [0.0, 1.0]).createShader(bounds);
                        },
                        child: Icon(
                          Icons.favorite,
                          size: 32.h,
                        )),
                  )),
            ],
          ),
        ),
      ),
      Align(
          alignment: Alignment.topCenter,
          child: CardSwiper(
              initialIndex: data.index,
              numberOfCardsDisplayed: 1,
              duration: const Duration(milliseconds: 200),
              cardsCount: data.cards.length,
              isLoop: false,
              allowedSwipeDirection:
                  AllowedSwipeDirection.only(left: true, right: true),
              cardBuilder: (context, index, i, i2) {
                return data!.cards[index];
              },
              onUndo: (previousIndex, currentIndex, direction) {
                if (widget.matchScreen) {
                  provider
                      .removeFromBlocked(data!.cards[currentIndex].user.uid);
                  provider
                      .addToPending(data.cards[currentIndex].user.uid);
                } else {
                  provider
                      .removeFromBlocked(data!.cards[currentIndex].user.uid);
                  provider
                      .removeFromLiked(data.cards[currentIndex].user.uid);
                }

                return true;
              },
              controller: cardController,
              onSwipe:
                  (previousIndex, currentIndex, CardSwiperDirection direction) async {
                if (direction.name == "left") {
                  if (widget.matchScreen) {
                    provider
                        .deletePendingAndBlock(data!.cards[previousIndex].user.uid);
                    provider
                        .setIndex(currentIndex ?? data.cards.length - 1);
                  } else {
                    provider
                        .addToBlocked(data!.cards[previousIndex].user.uid);
                    provider
                        .setIndex(currentIndex ?? data.cards.length - 1);
                  }
                } else if (direction.name == "right") {
                  if (widget.matchScreen) {
                    provider
                        .deletePendingAndLike(data!.cards[previousIndex].user.uid);
                    provider
                        .setIndex(currentIndex ?? data.cards.length - 1);
                    sendTextMessage(context, data.cards[previousIndex].user.uid);
                    await MessagingApi().callOnFcmApiSendPushNotifications(data.cards[previousIndex].user.fcmToken, "mutual_match".tr(), "mutual_match_body".tr());
                  } else {
                    provider
                        .addToLiked(data!.cards[previousIndex].user.uid);
                    provider
                        .setIndex(currentIndex ?? data.cards.length - 1);
                    await MessagingApi().callOnFcmApiSendPushNotifications(data.cards[previousIndex].user.fcmToken, "new_match".tr(), "new_match_body".tr());
                  }
                }

                if (previousIndex == data!.cards.length - 1) {
                  provider.setIndex(0);
                  provider.setCards();
                }

                return true;
              })),
    ],
  );
  }
}
