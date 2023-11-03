import 'dart:convert';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:saffety/Provider/appProvider.dart';
import 'package:saffety/screens/home.dart';
import 'package:saffety/screens/profile.dart';
import '../Models/JobsMode.dart';
import '../main.dart';
import '../utils/widgets/AppDrawer.dart';
import 'Mock_test.dart';
import 'WebinerPage.dart';
import 'chat.dart';
import 'package:http/http.dart' as http;


class Home_Page extends StatefulWidget {
  Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  //int _currentPageIndex = 0;
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
      drawer: Consumer<AppProvider>(builder: (context,provider,child){
        return AppDrawer(
          onWebinarTapped: () {
            provider.setCurrentPageIndex(3);
            setState(() {
              //_currentPageIndex = 3; // Set the index of the WebinerPage in the bottomNavigationBar
            });
            Navigator.pop(context); // Close the side drawer
          },
          onMockTestTapped: () {
            provider.setCurrentPageIndex(1);
            setState(() {
              //_currentPageIndex = 1;
            });
            Navigator.pop(context);

          },
          onProfilePageTapped: () {
          provider.setCurrentPageIndex(4);
          setState(() {
            //_currentPageIndex = 4;
          });
          Navigator.pop(context);

        },
          onHomePageTapped: () {
            provider.setCurrentPageIndex(0);
            Navigator.pop(context);
          },
        );
      },),
      appBar: AppBar(
        backgroundColor: Color(0xFF0058AC),
        //THE CERTIFIED SAFETY PROFESSIONAL
        title: Text("The Certified Safety Professional",style: TextStyle(fontSize: 16.sp),),
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
      //body: _pages[_currentPageIndex], // Display the appropriate page widget based on the selected item index
      body:  Consumer<AppProvider>(builder: (context,provider,child){
        return _pages[provider.currentPageIndex];
      },), // Display the appropriate page widget based on the selected item index
      bottomNavigationBar: Consumer<AppProvider>(builder: (context,provider,child){
        return CurvedNavigationBar(
          items: [
            CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined,size: 30.0.h,color: Colors.white,),
              label: 'Home',
              labelStyle: TextStyle(color: Colors.white,fontSize: 11.0.sp),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.quiz,size: 30.0.h,color: Colors.white,),
              label: 'Exam',
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
          animationDuration: const Duration(milliseconds: 600),
          index: provider.currentPageIndex,
          onTap: (index) {
            provider.setCurrentPageIndex(index);
            setState(() {
              //_currentPageIndex = index;
            });
          },
        );
      },),
    );
  }
}
