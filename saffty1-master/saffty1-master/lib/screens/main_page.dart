import 'dart:convert';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saffety/screens/home.dart';
import 'package:saffety/screens/profile.dart';
import '../Models/JobsMode.dart';
import '../main.dart';
import 'Mock_test.dart';
import 'Webiner.dart';
import 'chat.dart';
import 'package:http/http.dart' as http;


class Home_Page extends StatefulWidget {
  Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  int _currentIndex = 0;
  static List<JobsModel> Jobslist = [];

  // List of pages to display in the bottom navigation bar
  final List<Widget> _pages = [
    HomePage(),
    MockTest(),
    ChatPage(),
    WebinerPage(),
    ProfilePage(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        onWebinarTapped: () {
          setState(() {
            _currentIndex = 3; // Set the index of the WebinerPage in the bottomNavigationBar
          });
          Navigator.pop(context); // Close the side drawer
        },
      ),      appBar: AppBar(
        backgroundColor: Color(0xFF0058AC),
        title: Text("The Certificate Safely Professional",style: TextStyle(fontSize: 16.sp),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0.h),
          child: Container(
            margin: EdgeInsets.all(10.0.w),
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0.r),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: _pages[_currentIndex], // Display the appropriate page widget based on the selected item index
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined,size: 30.0.h,color: Colors.white,),
            label: 'Home',
            labelStyle: TextStyle(color: Colors.white,fontSize: 11.0.sp),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.quiz,size: 30.0.h,color: Colors.white,),
            label: 'Quiz',
            labelStyle: TextStyle(color: Colors.white,fontSize: 11.0.sp),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.chat,size: 30.0.h,color: Colors.white,),
            label: 'Chat',
            labelStyle: TextStyle(color: Colors.white,fontSize: 11.0.sp),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.note,size: 30.0.h,color: Colors.white,),
            label: 'Webinar',
            labelStyle: TextStyle(color: Colors.white,fontSize: 11.0.sp),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person,size: 30.0.h,color: Colors.white,),
            label: 'Profile',
            labelStyle: TextStyle(color: Colors.white,fontSize: 11.0.sp),
          ),
        ],
        color: Color(0xFF0058AC),
        buttonBackgroundColor: Colors.green,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });        },
      ),
    );
  }
}
