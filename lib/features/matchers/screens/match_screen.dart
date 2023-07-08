import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/features/matchers/controller/match_controller.dart';

class MatchScreen extends ConsumerStatefulWidget {
  static const String routeName = '/match-screen';
  const MatchScreen({super.key});

  @override
  ConsumerState<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  late CardSwiperController cardController;

  @override
  void initState() {
    cardController = CardSwiperController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CardsState data = ref.watch(matchControllerProvider);

    if (data.cards.isEmpty) {
      ref.read(matchControllerProvider.notifier).setCards();
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image(
                    width: ScreenUtil().setWidth(200),
                    height: ScreenUtil().setWidth(200),
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/sorry.png')),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(30.0)),
                child: Text("There is no one around you ...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        wordSpacing: 1.2,
                        fontSize: ScreenUtil().setSp(26.0),
                        fontWeight: FontWeight.w300,
                        color: Colors.grey.shade600)),
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                          padding: EdgeInsets.all(15.sp),
                          height: 55.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0.0, 0.0),
                                    color: Colors.grey),
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
                              child: Image(
                                image: AssetImage(
                                    'assets/images/closeRounded.png'),
                              ),
                              blendMode: BlendMode.srcATop,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                    colors: [
                                      Coloors.accentColor,
                                      Coloors.primaryColor
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: [0.0, 1.0]).createShader(bounds);
                              }),
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
                                    offset: Offset(0.0, 0.0),
                                    color: Colors.grey),
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
                              child: Image(
                                  image: AssetImage('assets/images/round.png')),
                              blendMode: BlendMode.srcATop,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                    colors: [
                                      Colors.amber.shade700,
                                      Colors.amber.shade400
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: [0.0, 1.0]).createShader(bounds);
                              }),
                        )),
                    GestureDetector(
                        onTap: () => cardController.swipeRight(),
                        child: Container(
                          padding: EdgeInsets.all(15.sp),
                          height: 55.h,
                          width: 55.h,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0.0, 0.0),
                                    color: Colors.grey),
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
                              child: Icon(
                                Icons.favorite,
                                size: 32.h,
                              ),
                              blendMode: BlendMode.srcATop,
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                    colors: [
                                      Colors.tealAccent.shade700,
                                      Colors.tealAccent.shade200
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    stops: [0.0, 1.0]).createShader(bounds);
                              }),
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
                      return data.cards[index];
                    },
                    onUndo: (previousIndex, currentIndex, direction) {
                      ref
                          .read(matchControllerProvider.notifier)
                          .removeFromBlocked(data.cards[currentIndex].uid);
                      ref
                          .read(matchControllerProvider.notifier)
                          .addToPending(data.cards[currentIndex].uid);

                      return true;
                    },
                    controller: cardController,
                    onSwipe: (previousIndex, currentIndex,
                        CardSwiperDirection direction) {
                      if (direction.name == "left") {
                        print("LEFT");
                        ref
                            .read(matchControllerProvider.notifier)
                            .deletePending(data.cards[previousIndex].uid);
                        ref
                            .read(matchControllerProvider.notifier)
                            .setIndex(currentIndex ?? data.cards.length - 1);
                      } else if (direction.name == "right") {
                        print("RIGHT");
                        // create chat
                        ref
                            .read(matchControllerProvider.notifier)
                            .setIndex(currentIndex ?? data.cards.length - 1);
                      }

                      if (previousIndex == data.cards.length - 1) {
                        ref.read(matchControllerProvider.notifier).setIndex(0);
                        ref.read(matchControllerProvider.notifier).setCards();
                        setState(() {});
                      }

                      return true;
                    })),
          ],
        ),
      ),
    );
  }

  double abs(double x) {
    if (x < 0) return x * -1;
    return x;
  }
}
