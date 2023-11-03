import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/ProfileModel.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:saffety/login_screens/otp.dart';
import 'package:email_validator/email_validator.dart' as mail;
import 'package:fluttertoast/fluttertoast.dart';
import '../API/Insert.dart';
import '../screens/tearmcondition.dart';
import '../utils/widgets/TransitionPage.dart';
import 'login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cpassController = TextEditingController();
  final phoneController = TextEditingController();
  static List<ProfileModel> Profilelist = [];
  final countryPicker = const FlCountryCodePicker();
  Random random = new Random();
  bool _obscureText = true;
  bool _passwordVisible = false;
  bool _passwordVisible1 = false;
  final countryPickerWithParams = const FlCountryCodePicker(
      localize: true,
      showDialCode: true,
      showFavoritesIcon: true,
      showSearchBar: true);
  CountryCode? countryCode;
  bool _checkBoxValue = false;
  String _errorMessage = '';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static final RegExp nameRegExp = RegExp('[a-zA-Z ]{2,10}');

//   Future<void> CreateAccount(String name, String phone, String email,
//       String code, String country, String password) async {
// // String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
//     final res = await http.post(
//         Uri.parse("https://royadagency.com/API/create_account.php"),
//         body: <String, String>{
//           'name': name,
//           'phone': phone,
//           'email': email,
//           'code': code,
//           'country': country,
//           'password': password,
//         });
//     List<dynamic> lst;
//     if (res.statusCode == 200) {
//       print(res.body); //print raw response on console
//       var data = json.decode(res.body); //decoding json to array
//       if (data["error"]) {
//         lst = data["users"];
//         for (int i = 0; i < lst.length; i++) {
//           Map<dynamic, dynamic> json = lst[i];
//           Profilelist.add(ProfileModel(
//               id: json['id'],
//               name: json['name'],
//               email: json['email'],
//               phone: json['phone'],
//               code: json['code'],
//               country: json['country']));
//         }
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => RegistrationDoneAnimation()),
//         );
//
//         print("success");
//       } else {
//         print("error");
//       }
//     }
//   }

  Future<void> CreateAccount(String name, String phone, String email, String code, String country, String password) async {
    final res = await http.post(
      Uri.parse("https://royadagency.com/API/create_account.php"),
      body: <String, String>{
        'name': name,
        'phone': phone,
        'email': email,
        'code': code,
        'country': country,
        'password': password,
      },
    );

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        List<dynamic> lst = data["users"];
        for (int i = 0; i < lst.length; i++) {
          Map<dynamic, dynamic> json = lst[i];
          Profilelist.add(ProfileModel(
            id: json['id'],
            name: json['name'],
            email: json['email'],
            phone: json['phone'],
            code: json['code'],
            country: json['country'],
          ));
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegistrationDoneAnimation()),
        );

        print("success");
      } else {
        print("error");
        String errorMessage = data["message"];
        if (errorMessage == "Email already exists") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Registration Failed"),
                content: Text("The email address is already registered. Please use a different email address."),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }




  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisible1 = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title:   Text(
              'Register Now',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D0D26),
              ),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.all(16.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.h),
                  Image.asset(
                    'assets/images/splash.png', // replace with your image path
                    width: 202.w,
                    height: 134.h,
                  ),
                  SizedBox(height: 30.h),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      hintText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your full name';
                      } else if (!nameRegExp.hasMatch(value)) {
                        return 'Only alphabet allowed';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      hintText: 'Email ID',
                      prefixIcon: Icon(Icons.email),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !mail.EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),

                  /*  TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  hintText: 'Country',
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),*/
                  SizedBox(height: 20.h),
                  GestureDetector(
                      onTap: () async {
                        WidgetsFlutterBinding.ensureInitialized();
                        final code = await countryPickerWithParams.showPicker(
                            context: context);
                        setState(() {
                          countryCode = code;
                        });
                      },
                      child: Container(
                          width: double.infinity,
                          height: 60,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          // child: Text(countryCode?.dialCode??"+1")),),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              Text(countryCode?.name ?? "India"),
                            ],
                          ))),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Container(
                          height: 60,
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(countryCode?.dialCode ?? "+91",
                              style: TextStyle(fontSize: 15))),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            hintText: 'Mobile Number',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
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
                  SizedBox(height: 20.h),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: cpassController,
                    obscureText: !_passwordVisible1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible1 = !_passwordVisible1;
                          });
                        },
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != passController.text
                        ? 'Password not matched'
                        : null,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Checkbox(
                        value: _checkBoxValue,
                        onChanged: (value) {
                          setState(() {
                            _checkBoxValue = value!;
                            if(_checkBoxValue == true) {
                              _errorMessage = '';
                            }
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermCondition()),
                          );
                        },
                        child: const Text(
                          'I agree to the terms and conditions',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.sp),
                  //if (_checkBoxValue)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 20.sp),
                  GestureDetector(
                    //registration_animation
                    onTap: () {
                      print("Register Button Precede");
                      setState(() {
                        if (_checkBoxValue == false) {
                          _errorMessage = 'Please check the checkbox';
                        } else if (phoneController.text.isEmpty) {
                          _errorMessage = 'Please enter your mobile number';
                        } else {
                          _errorMessage = '';
                        }
                      });
                      if (formkey.currentState!.validate() && _checkBoxValue && phoneController.text.isNotEmpty) {
                        print("validated");
                        CreateAccount(
                          nameController.text,
                          phoneController.text,
                          emailController.text,
                          countryCode?.dialCode ?? "+91",
                          countryCode?.name ?? "+91",
                          passController.text,
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
                      child: Center(
                          child: Text(
                        'Register Now',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      )),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      SizedBox(width: 5.w),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ));
  }
}
