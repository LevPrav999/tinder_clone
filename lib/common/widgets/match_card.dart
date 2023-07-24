import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/utils/utils.dart';

import '../../src/domain/user_model.dart';
import '../utils/coloors.dart';

class MatchCard extends StatefulWidget {
  final UserModel user;

  const MatchCard(
      {super.key,
      required this.user});

  @override
  _MatchCardState createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade700,
              offset: const Offset(0.0, 5.0),
              blurRadius: 20.0)
        ],
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade700,
                    offset: const Offset(0.0, 5.0),
                    blurRadius: 15.0)
              ],
              borderRadius: BorderRadius.circular(100.0),
            ),
            height: MediaQuery.of(context).size.height * 0.74,
            width: MediaQuery.of(context).size.width - 10.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                  fit: BoxFit.cover, image: NetworkImage(widget.user.avatar)),
            ),
          ),
          Positioned(
            bottom: 15.h,
            left: 15.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: widget.user.isOnline ? Colors.greenAccent : Coloors.steelGray,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: widget.user.isOnline ? Color.fromARGB(255, 133, 222, 136) : Coloors.steelGray,
                                offset: Offset(1.0, 2.0),
                                blurRadius: 10.0)
                          ]),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      widget.user.name,
                      style: TextStyle(
                          shadows: [
                            Shadow(
                                color: widget.user.isPrime ? Coloors.sunnyYellow : Colors.black54,
                                offset: widget.user.isPrime ? Offset(2.0, 3.0) : Offset(1.0, 2.0),
                                blurRadius: 10.0)
                          ],
                          color:  Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      getAge(widget.user.age['year']),
                      style: TextStyle(
                          shadows: [
                            Shadow(
                                color: widget.user.isPrime ? Coloors.sunnyYellow : Colors.black54,
                                offset: Offset(1.0, 2.0),
                                blurRadius: 10.0)
                          ],
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  widget.user.bio,
                  style: TextStyle(
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(1.0, 2.0),
                            blurRadius: 10.0)
                      ],
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w400),
                ),
                widget.user.tags.isNotEmpty ? SizedBox(
                  height: 5.h,
                ) : SizedBox(
                  height: 0.h,
                ),
                widget.user.tags.isNotEmpty ? Row(
                  children: [
                    for (var i = 0;
                        i < (widget.user.tags.length > 4 ? 3 : widget.user.tags.length);
                        i++)
                      Container(
                        decoration: BoxDecoration(
                          color: Coloors.skyBlue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.all(2.0),
                        child: Text(
                          widget.user.tags[i],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (widget.user.tags.length > 4)
                      Container(
                        decoration: BoxDecoration(
                          color: Coloors.skyBlue,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.all(2.0),
                        child: Text(
                          "${widget.user.tags.length - 3}+",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ) : Container(),
              ],
            ),
          ),
          Positioned(
            bottom: 1.0,
            right: -1.0,
            child: Container(
              width: MediaQuery.of(context).size.width - 22.0,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                      colors: [Colors.transparent, Colors.black26],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 1.0])),
            ),
          )
        ],
      ),
    );
  }
}
