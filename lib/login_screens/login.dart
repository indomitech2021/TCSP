import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saffety/login_screens/register.dart';
import 'package:email_validator/email_validator.dart' as mail;
import '../API/UserSimplePreferences.dart';
import '../screens/home.dart';
import '../screens/main_page.dart';
import 'forgot.dart';
import '../Models/ProfileModel.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  static List<ProfileModel> Profilelist = [];

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  Future<void> login(String email, String password) async {
    print(email);
    print(password);
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/login.php"),
        body: <String, String>{
          'email': email,
          'pass': password,
        });
    List lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"] == true) {
        lst = data["user"];
        for (int i = 0; i < lst.length; i++) {
          Map<String, dynamic> json = lst[i];
          Profilelist.add(ProfileModel(
              id: json['id'],
              name: json['name'],
              email: json['email'],
              phone: json['phone'],
              code: json['code'],
              country: json['country'],
              resume: json['resume']));
          UserSimplePreferences.init();
          UserSimplePreferences.setID(await json["id"]);
          UserSimplePreferences.setPhone(await json["phone"]);
          UserSimplePreferences.setName(await json['name']);
          UserSimplePreferences.setEmail(await json['email']);
          UserSimplePreferences.setPic(await json['image']);
          UserSimplePreferences.setResume(await json['resume']);
          // UserSimplePreferences.setPwd(await json['pwd']));
          //Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home_Page()),
          );
        }
        print("success");
      } else {
        print(data["message"]);
        Fluttertoast.showToast(
            msg: data["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                Text(
                  'Welcome To',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D0D26),
                  ),
                ),
                SizedBox(height: 20.h),
                Image.asset(
                  'assets/images/splash.png', // replace with your image path
                  width: 202.w,
                  height: 134.h,
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      labelText: 'Email ID',
                      hintText: 'Email ID',
                      suffixIcon: Icon(Icons.email),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !mail.EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      labelText: 'Password',
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min. 6 characters'
                        : null,
                  ),
                ),
                SizedBox(height: 40.h),
                TextButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      print("validated");
                      login(emailController.text, passwordController.text);
                      print(emailController.text);
                      print(passwordController.text);
                    }
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
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    )),
                  ),
                ),
                SizedBox(height: 30.h),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerificationPage()),
                    );
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF0058AC),
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    color: Color(0xFF494A50),
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    Timer(Duration(milliseconds: 5), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()),
                      );
                    });
                  },
                  child: Container(
                    width: 327.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: Color(0xFF027BEE),
                    ),
                    child: Center(
                        child: Text(
                      'Register Now',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
