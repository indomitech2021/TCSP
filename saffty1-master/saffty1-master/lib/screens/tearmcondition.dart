import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermCondition extends StatefulWidget {
  const TermCondition({Key? key}) : super(key: key);

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Privacy Policy',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text('Please read this Terms and Conditions carefully before using the http://www.my website.com website and my mobile app, mobile application operated by my company.',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade800
              ),),
            SizedBox(height: 10.h,),
            Text('Your access to and use of the service is conditioned on your acceptance of and complaints with this terms. These terms apply to all visitors users and others who access are use the service.',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade800
              ),),
            SizedBox(height: 20.h,),
            Text('By accessing or using the service you agree to be bounded by this terms if you disagree with any part of the terms then you may not access the service',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 20.h,),
            Text('If you wish to purchase any product or service may available so the service you may be outs to supply certain information relevant to your purchase including without limitation',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade800
              ),),
            SizedBox(height: 20.h,),
            Text('Links to other websites',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 20.h,),
            Text('Our service mein content links to third party website or service that are not owned or conditioned by my company',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade800
              ),),
            SizedBox(height: 10.h,),
            Text('My company has no control over and assumes no responsibility for the content privacy policy or practice of any third party website or services your future acknowledgement and agree that my company shell not be responsible for 11 directly or indirectly for any damage or loss caused or else to be caused by in connection with use of all Reliance or any such contents goes or service available on or so any such sites or services',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade800
              ),),
            Spacer(),
          ],
        ),
      ),
    ));  }
}
