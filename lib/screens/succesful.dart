import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'main_page.dart';

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({Key? key}) : super(key: key);

  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Successful',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Spacer(),
          //SuccessfulAnimation
          Lottie.asset(
            'assets/Animation/SuccessfulAnimation.json', // Replace with the path to your Lottie animation file
            width: 300.sp,
            //height: 500.sp,
          ),
          // Image.asset('assets/images/tick.png',
          //   height: 150.h,
          //   width: 150.w,),
          Spacer(),
          Text(
            'Your application has been\nsubmitted!',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home_Page()),
              );
            },
            child: Container(
              width: 327.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0xFF0058AC),
              ),
              child: Center(
                  child: Text(
                    'Go To Home',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  )),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
