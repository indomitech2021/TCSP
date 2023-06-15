import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saffety/screens/main_page.dart';

class QuizResultPage extends StatefulWidget {
  @override
  _QuizResultPageState createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/result.png'),
            SizedBox(height: 16.h),
            Text(
              'Result of GK Quiz',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.h),
            _buildResultContainer(
              icon: Icons.sports_score_sharp,
              color: Colors.blue.shade700,
              text1: 'Total score',
              text2: '80',
            ),
            _buildResultContainer(
              icon: Icons.check,
              color: Colors.green,
              text1: 'Correct',
              text2: '10',
            ),
            _buildResultContainer(
              icon: Icons.close,
              color: Colors.red,
              text1: 'Incorrect',
              text2: '5',
            ),
            _buildResultContainer(
              icon: Icons.touch_app_outlined,
              color: Colors.yellow.shade800,
              text1: 'Not Touch',
              text2: '10',
            ),
            SizedBox(height: 40.h,),
            GestureDetector(
              onTap: () {
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
                child: Center(
                  child: Text(
                    'Go To Home',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

    Widget _buildResultContainer({required IconData icon, required Color color, required String text1, required String text2}) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
        child: Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.blue[50],
          ),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: Icon(icon, color: color),
              ),
              SizedBox(width: 8.w),
              Text(
                text1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(text2),
              SizedBox(width: 8.w),
            ],
          ),
        ),
      );
    }
}

