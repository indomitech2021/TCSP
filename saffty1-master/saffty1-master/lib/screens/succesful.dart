import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_page.dart';

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({Key? key}) : super(key: key);

  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Center(child: Text('Successful',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.sp),)),
            Spacer(),
            Image.asset('assets/images/tick.png',
              height: 150.h,
              width: 150.w,),
            Spacer(),
            Text('Your job apply successful!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp),),
            Spacer(),
            GestureDetector(
              onTap: (){
                Navigator.push(
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
                child: Center(child: Text('Go To Home',style: TextStyle(color: Colors.white,fontSize: 16.sp),)),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );  }
}
