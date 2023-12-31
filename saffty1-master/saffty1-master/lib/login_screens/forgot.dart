import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saffety/API/fetch.dart';
import 'package:saffety/login_screens/login.dart';
import 'package:saffety/login_screens/otp.dart';
import '../API/UserSimplePreferences.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
 final emailController = TextEditingController();


 Future<void>  ForgotPassword(String email,String otp) async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
   final res = await http.post(
       Uri.parse("https://royadagency.com/API/forgot_password.php"),
       body: <String, String>{
         'email':email,
         'otp':otp
       });
   List lst;
   if (res.statusCode == 200) {
     print(res.body); //print raw response on console
     var data = json.decode(res.body); //decoding json to array
     if (data["error"]) {
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => OtpPage(otp: otp, email: email)),
       );
     }
     else
     {

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50.h),
              Container(
                height: 95.h,
                width: 311.w,
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Enter your email or phone number, we will send \n your verification code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding:  EdgeInsets.all(20.sp),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    hintText: 'abcd.text@gmail.com',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              GestureDetector(
                onTap: (){
                  var rng = new Random();
                  var code = rng.nextInt(9000) + 1000;
                  if(emailController.text!="") {
                    ForgotPassword(emailController.text, code.toString());
                  }
                  else
                    {
                      Fluttertoast.showToast(
                          msg: "Please write your email id",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                },
                child: Container(
                  width: 327.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Color(0xFF0058AC),
                  ),
                  child: Center(child: Text('Send Code',style: TextStyle(color: Colors.white,fontSize: 16.sp),)),
                ),
              ),
              SizedBox(height: 150.h),
            ],
          ),
        ),
      ),
    );
  }
}
