import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saffety/API/UserSimplePreferences.dart';
import 'package:saffety/screens/main_page.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../API/fetch.dart';
import '../login_screens/login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final passController = TextEditingController();
  final cpassController = TextEditingController();
  final opassController = TextEditingController();
  bool _passwordVisible  = false;
  bool _passwordVisible1  = false;
  bool _passwordVisible2  = false;


  Future<void>  ChangePassword(String email,String password,String old) async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/changePassword.php"),
        body: <String, String>{
          'email':email,
          'password':password,
          'old':old
        });
    List lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {

        Fluttertoast.showToast(
            msg: data["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        new Future.delayed(new Duration(seconds: 3), () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
      });
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
    return  Form(key:formkey,
    child:  ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 130.h),
                Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D0D26),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Enter your new password and confirm the new password to change password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: opassController,
                  obscureText: !_passwordVisible2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible2
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ), onPressed: () {
                      setState(() {
                        _passwordVisible2 = !_passwordVisible2;
                      });
                    },
                    ),),
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction,
                  validator: (value) =>
                  value != null && value.length < 6
                      ? 'Enter min. 6 characters'
                      : null,
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: passController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ), onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    ),),
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction,
                  validator: (value) =>
                  value != null && value.length < 6
                      ? 'Enter min. 6 characters'
                      : null,
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: cpassController,
                  obscureText: !_passwordVisible1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible1 ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ), onPressed: () {
                      setState(() {
                        setState(() {
                          _passwordVisible1 = !_passwordVisible1;
                        });
                      });
                    },
                    ),),
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction,
                  validator: (value) =>
                  value!=passController.text?
                  'Password not matched' : null,

                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                  if (formkey.currentState!.validate()) {
                  print("validated");
                    String? email = UserSimplePreferences.getEmail() != null? UserSimplePreferences.getEmail().toString():"";
                    print(email);
                    ChangePassword(email, passController.text, opassController.text);

                  }},
                  child: Container(
                    width: 350.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: Color(0xFF0058AC),
                    ),
                    child: Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),);
  }
}
