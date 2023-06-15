import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/ProfileModel.dart';

class Insert extends StatefulWidget{
  static List<ProfileModel> Profilelist = [];
  static bool flag=false;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

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
        flag=true;
        print("success");
      }
      else
        {
          flag=false;
          print("error");
        }
    }
  }
}