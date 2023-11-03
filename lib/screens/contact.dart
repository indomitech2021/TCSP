import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saffety/utils/const.dart';
import 'main_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}
class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBlue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        title: Text(
          'Contact Us',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.sp,),
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
              SizedBox(height: 20.sp),
              Text(
                'Enquiry Form',
                style: TextStyle(
                  fontSize: 20.sp, // added fontsize in sp
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D0D26),
                ),
              ),
              SizedBox(height: 20.sp), // added height in height
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp), // added border-radius in sp
                  ),
                  hintText: 'Miss Najema',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20.sp), // added height in height
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp), // added border-radius in sp
                  ),
                  hintText: 'Email Id',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: 20.sp), // added height in height
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp), // added border-radius in sp
                  ),
                  hintText: 'Subject',
                  prefixIcon: Icon(Icons.menu),
                ),
              ),
              SizedBox(height: 20.sp), // added height in height
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp), // added border-radius in sp
                  ),
                  hintText: 'Message',
                  // prefixIcon: Icon(Icons.menu),
                ),
              ),
              SizedBox(height: 33.sp), // added height in height
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 327.w, // added width in width
                  height: 56.h, // added height in height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp), // added border-radius in sp
                    color: Color(0xFF0058AC),
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp, // added fontsize in sp
                        height: 1.5.h, // added line-height in height
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.sp),


            ],
          ),
        ),
      ),

    );
  }
}
