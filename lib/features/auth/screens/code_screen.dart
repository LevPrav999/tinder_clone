import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';

class CodeScreen extends ConsumerWidget {
  static const String routeName = '/code-screen';
  final String verificationId;
  const CodeScreen({super.key, required this.verificationId});

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP){
    ref.read(authControllerProvider).vetifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const Text("Verifying your number"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: [
          const SizedBox(height: 20),
          const Text("We have sent an SMS with a code."),
          SizedBox(
            width: size.width * 0.5,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: '------',
                hintStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value){
                if(value.length == 6){
                  verifyOTP(ref, context, value);
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}


