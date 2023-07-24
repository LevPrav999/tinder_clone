import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/new/presentaion/states/user_state.dart';

import '../../../../common/utils/coloors.dart';
import '../../../../common/utils/utils.dart';
import '../match_screen.dart';
import '../tags_screen.dart';
import '../user_info_screen.dart';

class ProfileTabScreen extends ConsumerStatefulWidget {
  const ProfileTabScreen({super.key});

  @override
  ConsumerState<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends ConsumerState<ProfileTabScreen> {

  @override
  Widget build(BuildContext context) {
    var data = ref.watch(userStateProvider);
    return Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade100,
              ),
              ClipPath(
                clipBehavior: Clip.antiAlias,
                clipper: MyClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.825,
                  decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 10.0),
                        blurRadius: 10.0)
                  ]),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30.h),
                              CircleAvatar(
                                radius: 60.0,
                                foregroundImage:
                                    NetworkImage(data!.avatar),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "${data.name}, ${getAge(data.age['year'])}",
                                style: TextStyle(
                                    letterSpacing: 1.1,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Expanded(
                                  child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, TagsScreen.routeName, arguments: data.tags);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 40.w,
                                            height: 35.h,
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey.shade50,
                                                borderRadius:
                                                    BorderRadius.circular(100.0)),
                                            child: Icon(
                                              Icons.tag_rounded,
                                              size: 25.sp,
                                              color: Colors.blueGrey.shade200,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            "tags".tr(),
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade200,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child:GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(context, MatchScreen.routeName);
                                        },
                                        child: Stack(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                      ),
                                      Positioned(
                                        right: 1.0,
                                        bottom: 0.0,
                                        left: 1.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              width: 50.h,
                                              height: 50.h,
                                              decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                      colors: [
                                                        Coloors.accentColor,
                                                        Coloors.secondaryHeaderColor,
                                                        Coloors.primaryColor
                                                      ],
                                                      begin: Alignment.topRight,
                                                      end:
                                                          Alignment.bottomRight,
                                                      stops: [0.0, 0.35, 1.0]),
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          150.0)),
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                                size: 32.sp,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "suggestions".tr(),
                                              style: TextStyle(
                                                  color:
                                                      Colors.blueGrey.shade200,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 40.w,
                                        bottom: 31.w,
                                        child: Container(
                                          width: 15.w,
                                          height: 15.h,
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(2.0, 3.0),
                                                  blurRadius: 5.0,
                                                )
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color:
                                                  Coloors.accentColor,
                                              size: 15.sp,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ))),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context, UserInfoScreen.routeName, arguments: {
                                        'name': data.name,
                                        'age': "${data.age['day']}.${data.age['month']}.${data.age['year']}",
                                        'sex': data.sex,
                                        'city': data.city,
                                        'bio': data.bio,
                                        'sexFind': data.sexFind, 
                                        'avatar' : data.avatar,
                                        'fromProfile': true
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 40.w,
                                          height: 35.h,
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          child: Icon(
                                            Icons.edit,
                                            size: 25.sp,
                                            color: Colors.blueGrey.shade200,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          "edit_info".tr(),
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade200,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                      Expanded(flex: 3, child: Container())
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 20.h,
                  child: Container(
                    height: 180.h,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 150.h,
                        aspectRatio: 16 / 2,
                        viewportFraction: 0.8,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayInterval: const Duration(seconds: 2),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        pauseAutoPlayOnTouch: true,
                      ),
                      items: [0, 1, 2, 3, 4, 5].map((i) {
                        return Builder(
                          builder: (context) {
                            return Container(
                              width: 450.w,
                              height: 80.h,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Coloors.primaryColor,
                                      width: 2),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 5.0),
                                        blurRadius: 10.0)
                                  ],
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      quotes[i].heading,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      quotes[i].baseline,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              )),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ))
            ],
          );
  }
}


class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(0, size.height - 100.h);
    Offset controlPoint = Offset(size.width / 2, size.height);
    p.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, size.width, size.height - 100.h);
    p.lineTo(size.width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Quotes {
  final String heading;
  final String baseline;

  Quotes(this.heading, this.baseline);
}

List<Quotes> quotes = [
  Quotes("get_tinder_gold".tr(), "see_who_likes_you_more".tr()),
  Quotes("get_matches_faster".tr(), "boost_your_profile_once_a_month".tr()),
  Quotes("i_meant_to_swipe_right".tr(), "get_unlimited_rewinds_with_tinder_plus".tr()),
  Quotes("stand_out_with_super_likes".tr(),
      "youre_3_times_more_likely_to_get_a_match".tr()),
  Quotes("increase_your_chances".tr(), "get_unlimited_likes_with_tinder_plus".tr()),
  Quotes("swipe_around_the_world".tr(), "passport_to_anywhere_with_tinder_plus".tr()),
];
