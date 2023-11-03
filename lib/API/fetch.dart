import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../Models/ProfileModel.dart';
import 'UserSimplePreferences.dart';

class Fetch extends StatefulWidget{
  static List<ProfileModel> Profilelist = [];
  static bool flag=false;
  static String msg="";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
  @override
  void initState() {
   flag=false;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return  Container();
  }
  Future<void>  login(String email,String password) async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/login.php"),
        body: <String, String>{
          'email':email,
          'pass': password,
        });
    List lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        lst = data["user"];
        flag=true;
        for (int i = 0; i < lst.length; i++) {
          Map<String, dynamic> json = lst[i];
          Profilelist.add(ProfileModel(
              id: json['id'],
              name: json['name'],
              email: json['email'],
              phone: json['phone'],
              code: json['code'],
              country: json['country']
          ));
        UserSimplePreferences.init();
        UserSimplePreferences.setID(await json["id"]);
        UserSimplePreferences.setPhone(await json["phone"]);
        UserSimplePreferences.setName(await json['name']);
        UserSimplePreferences.setEmail(await json['email']);
       // UserSimplePreferences.setPwd(await json['pwd']));

    }
      print("success");
      }
      else
        {
          flag=false;
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
       flag=true;
      }
      else
      {
        flag=false;
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

  Future<void>  NewPassword(String email,String password) async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/NewPassword.php"),
        body: <String, String>{
          'email':email,
          'password':password
        });
    List lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      flag=true;
      if (data["error"]) {
        msg=data["message"];
        Fluttertoast.showToast(
            msg: data["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
      else
      {
        flag=false;
        msg=data["message"];
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
      flag=true;
      if (data["error"]) {
        msg=data["message"];
        Fluttertoast.showToast(
            msg: data["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
      else
      {
        flag=false;
        msg=data["message"];
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
}