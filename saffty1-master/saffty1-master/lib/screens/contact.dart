import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'enquiry.dart';
import 'main_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}
class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Contact Us',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Spacer(),
            Center(
              child: Material(
                elevation: 3,
                child: Container(
                  height: 200.h,
                  width: 349.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  padding: EdgeInsets.all(16.sp),
                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'THE CERTIFIED SAFETY PROFESSIONAL',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                            fontSize: 14.sp,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.grey,
                              size: 20.sp,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              '123-456-7890',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Icon(
                              Icons.message,
                              color: Colors.grey,
                              size: 20.sp,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              'example@domain.com',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Icon(
                              Icons.pin_drop,
                              color: Colors.grey,
                              size: 20.sp,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              '123 Main St, Anytown USA',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Material(
              elevation: 3,
              child: Container(
                height: 241.h,
                width: 349.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Image.asset(
                  'assets/images/location.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 60.h),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnquiryPage()),
                );
              },
              child: Container(
                width: 327.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: Color(0xFF0058AC),
                ),
                child: Center(
                    child: Text(
                      'Enquiry',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    )),
              )),
            Spacer(),
          ],
        ),
      ),

    ));
  }
}
