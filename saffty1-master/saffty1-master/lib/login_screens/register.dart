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
  final countryPicker = const  FlCountryCodePicker();
  Random random = new Random();
  bool _obscureText = true;
  bool _passwordVisible  = false;
  bool _passwordVisible1  = false;
  final countryPickerWithParams = const FlCountryCodePicker(
    localize: true,
    showDialCode: true,
    showFavoritesIcon: true,
    showSearchBar: true
  );
  CountryCode? countryCode;
  bool _checkBoxValue = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static final RegExp nameRegExp = RegExp('[a-zA-Z ]{2,10}');

  Future<void>  CreateAccount(String name,String phone,String email,String code,String country,String password) async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/create_account.php"),
        body: <String, String>{
          'name':name,
          'phone': phone,
          'email' :email,
          'code':code,
          'country':country,
          'password':password,
        });
    List<dynamic> lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        lst = data["users"];
        for (int i = 0; i < lst.length; i++) {
          Map<dynamic, dynamic> json = lst[i];
          Profilelist.add(ProfileModel(
              id: json['id'],
              name: json['name'],
              email: json['email'],
              phone: json['phone'],
              code: json['code'],
              country: json['country']
          ));
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );

        print("success");
      }
      else
      {

        print("error");
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
    return Form(key:formkey,
    child:Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              Text(
                'REGISTER NOW',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D0D26),
                ),
              ),
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
                    return '*required';
                  }
                  else if(!nameRegExp.hasMatch(value))
                  {
                    return 'Only alphabet allowed';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  hintText: 'Email ID',
                  prefixIcon: Icon(Icons.email),
                ),
                autovalidateMode: AutovalidateMode
                    .onUserInteraction,
                validator: (email) =>
                email != null &&
                    !mail.EmailValidator.validate(email)
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
                  final code=await countryPickerWithParams.showPicker(context: context);
                  setState(() {
                    countryCode=code;
                  });
                },
                child:Container(width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration( border:Border.all(width: 1,color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r),

                ),
                   // child: Text(countryCode?.dialCode??"+1")),),
                child:Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(countryCode?.name??"India"),
                  ],
                ))),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Container( height: 60,
                    padding: EdgeInsets.only(top:20,left:10,right:10),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration( border:Border.all(width: 1,color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r),),
                      child: Text(countryCode?.dialCode??"+91",style: TextStyle(fontSize: 15))),
                  Container(
                    width: 250,
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        hintText: 'Mobile number',
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                ],
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
                          _passwordVisible1 = !_passwordVisible1;
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
              Row(
                children: [
                  Checkbox(
                    value: _checkBoxValue,
                    onChanged: (value) {
                      setState(() {
                        _checkBoxValue = value!;
                      });
                    },
                  ),
                  Text('I agree to the terms and\nconditions',textAlign: TextAlign.center,),
                ],
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: (){
                  print("hello");
                  int randomNumber = random.nextInt(100);
                          if (formkey.currentState!.validate()) {
                              print("validated");
                              setState(() {
                                if (_checkBoxValue == true) {
                                  CreateAccount(nameController.text,
                                      phoneController.text,
                                      emailController.text,
                                      countryCode?.dialCode ?? "+91",
                                      countryCode?.name ?? "+91",
                                      passController.text);
                                }
                              });
                          }
                },
                child: Container(
                  width: 327.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Color(0xFF0058AC),
                  ),
                  child: Center(child: Text('Register Now',style: TextStyle(color: Colors.white,fontSize: 16.sp),)),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  SizedBox(width: 5.w),
                  TextButton(
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );},
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}



