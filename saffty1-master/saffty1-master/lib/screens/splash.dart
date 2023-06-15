import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../API/UserSimplePreferences.dart';
import '../login_screens/login.dart';
import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    UserSimplePreferences.init();
    Timer(Duration(seconds: 3), () {
           UserSimplePreferences.getEmail() != null?
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home_Page(),
          ),
        ) : Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen(),
            ),
          );

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),

            Container(
            width: MediaQuery.of(context).size.width,
        height: 300.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
            Spacer(),
            Text(
              'Developed by SYSCOGEN',
              style: TextStyle(fontSize: 16.sp,color: Color(0xFF0058AC)),
            ),
            SizedBox(height: 50.h,)
          ],
        ),
      ),
    );
  }
}