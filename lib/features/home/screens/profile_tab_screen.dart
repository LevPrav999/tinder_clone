import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';
import 'package:tinder_clone/features/auth/screens/user_information_screen.dart';

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
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                                "${data.name}, ${data.age['year'].toString()}",
                                style: TextStyle(
                                    letterSpacing: 1.1,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Expanded(
                                  child: Row(
                                children: <Widget>[
                                  Expanded(
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
                                            Icons.settings,
                                            size: 25.sp,
                                            color: Colors.blueGrey.shade200,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          "SETTINGS",
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade200,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
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
                                              "SUGGESTIONS",
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
                                              boxShadow: [
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
                                  )),
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
                                          "EDIT INFO",
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
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayInterval: Duration(seconds: 2),
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
                                  boxShadow: [
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

final Shader linearGradient = LinearGradient(
    colors: [Colors.amber.shade800, Colors.amber.shade600],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.0, 1.0]).createShader(Rect.fromLTWH(0.0, 0.0, 15.w, 10.h));

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
  Quotes("GET TINDER GOLD", "See who likes you & more!"),
  Quotes("Get matches faster", "Boost your profile once a month!"),
  Quotes("I meant to swipe right", "Get unlimited Rewinds with Tinder Plus!"),
  Quotes("Stand out with Super Likes",
      "You're 3 times more likely to get a match!"),
  Quotes("Increase your chances", "Get unlimited likes with tinder Plus!"),
  Quotes("Swipe around the world!", "Passport to anywhere with Tinder Plus!"),
];
