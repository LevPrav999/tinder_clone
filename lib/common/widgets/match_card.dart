import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/coloors.dart';

class MatchCard extends StatefulWidget {
  final String uid;
  final String name;
  final String imageURL;
  final String age;
  final String bio;

  const MatchCard(
      {super.key,
      required this.uid,
      required this.name,
      required this.imageURL,
      required this.age,
      required this.bio});

  @override
  _MatchCardState createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {

  List<String> tags = ["Psychology", "Photography", "Technology", "Lol", "Kek", "Cheburek"];

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
                  fit: BoxFit.cover, image: NetworkImage(widget.imageURL)),
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
                      decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 133, 222, 136),
                                offset: Offset(1.0, 2.0),
                                blurRadius: 10.0)
                          ]),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                          shadows: const [
                            Shadow(
                                color: Colors.black54,
                                offset: Offset(1.0, 2.0),
                                blurRadius: 10.0)
                          ],
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      widget.age.toString(),
                      style: TextStyle(
                          shadows: const [
                            Shadow(
                                color: Colors.black54,
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
                  widget.bio,
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
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    for (var i = 0;
                        i < (tags.length > 4 ? 3 : tags.length);
                        i++)
                      Container(
                        decoration: BoxDecoration(
                          color: Coloors.steelGray,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.all(2.0),
                        child: Text(
                          tags[i],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (tags.length > 4)
                      Container(
                        decoration: BoxDecoration(
                          color: Coloors.steelGray,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.all(2.0),
                        child: Text(
                          "${tags.length - 3}+",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
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
