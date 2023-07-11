import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/utils/coloors.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Coloors.secondaryHeaderColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0.0,
        title: Text(
          "Settings",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.w, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      colors: [Coloors.mintGreen, Coloors.accentColor])),
              child: Stack(
                children: [
                  Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/3d%20icons%2Fbattery-dynamic-color.png?alt=media&token=fec6ff58-b703-4674-9c96-4ac29198a12a",
                    fit: BoxFit.cover,
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Text(
                            "Make\nYourself",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "BOOSTED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Coloors.sunnyYellow,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: OutlinedButton(
              onPressed: () {},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Sign Out",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Coloors.lavenderPurple),
                    ),
                    Icon(Icons.arrow_forward, color: Coloors.lavenderPurple)
                  ]),
              style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      BorderSide(color: Coloors.lavenderPurple, width: 1.4)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 20, horizontal: 50)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))))),
            ),
          )
        ],
      )),
    );
  }
}
