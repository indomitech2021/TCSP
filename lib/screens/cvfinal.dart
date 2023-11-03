import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saffety/screens/main_page.dart';
import 'package:http/http.dart' as http;
import '../API/UserSimplePreferences.dart';
import 'cv.dart';

class CvFinal extends StatefulWidget {
  const CvFinal({Key? key}) : super(key: key);

  @override
  State<CvFinal> createState() => _CvFinalState();
}

class _CvFinalState extends State<CvFinal> {
  String resume="";
  String url="";

 Future<void>  ResumeFetch() async {
 String? email = UserSimplePreferences.getEmail()!= null? UserSimplePreferences.getEmail().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/FetchResume.php"),
        body: <String, String>{
          'email':email,
        });
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        resume = data["resume"];
        url="https://royadagency.com/Resumes/"+resume;
          /*Navigator.pop(context);
          Navigator.push(context,MaterialPageRoute(builder: (context) => Home_Page()),*//*
          );*/
        print("success");
        }
      else
      {
        print(data["message"]);
        Fluttertoast.showToast(
            msg: data["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }

  @override
  void initState() {
    setState(() {
      ResumeFetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('View Resume',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(height: 30,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tap icon to view your resume',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 50.0.h),
                    GestureDetector(
                      onTap: (){
                        launch(url);
                      },
                      child:  Image.asset(
                        'assets/images/pdf.png',
                        height: 100.0.h,
                        width: 100.0.w,
                      ),
                    ),
                    SizedBox(height: 60.0.h),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0.h),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home_Page()),
              );
            },
            child: Center(
              child: Container(
                width: 230,
                height: 56.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0.r),
                  color: Color(0xFF0058AC),
                ),
                child: TextButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadResumePage()),
                  );
                },
                child:Text('Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
            ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}