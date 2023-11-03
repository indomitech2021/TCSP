import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../login_screens/login.dart';

class RegistrationDoneAnimation extends StatefulWidget {
  RegistrationDoneAnimation({Key? key}) : super(key: key);
  @override
  State<RegistrationDoneAnimation> createState() => _RegistrationDoneAnimationState();
}

class _RegistrationDoneAnimationState extends State<RegistrationDoneAnimation> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3200), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/Animation/registration_animation.json', // Replace with the path to your Lottie animation file
          width: 300.sp, // Adjust the width and height as needed
          height: 300.sp,
        ),
      ),
    );
  }
}
