import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saffety/screens/Mock_test.dart';
import 'package:saffety/screens/WebinerPage.dart';
import 'package:saffety/screens/chat.dart';
import 'package:saffety/screens/contact.dart';
import 'package:saffety/screens/home.dart';
import 'package:saffety/screens/job.dart';
import 'package:saffety/screens/main_page.dart';
import 'package:saffety/screens/profile.dart';
import 'package:saffety/screens/splash.dart';
import 'package:saffety/screens/team.dart';
import 'package:saffety/screens/quizquestion.dart';

import '../../API/UserSimplePreferences.dart';
import '../../login_screens/login.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onWebinarTapped; // Add this line
  String? email = UserSimplePreferences.getEmail() != null
      ? UserSimplePreferences.getEmail().toString()
      : "";
  String? name = UserSimplePreferences.getName() != null
      ? UserSimplePreferences.getName().toString()
      : "";
  String? pic = UserSimplePreferences.getPic() != null
      ? "https://royadagency.com/images/user_images/" +
          UserSimplePreferences.getPic().toString()
      : "";
  //NavDrawer({required this.onWebinarTapped});

  final VoidCallback onMockTestTapped;
  final VoidCallback onProfilePageTapped;
  final VoidCallback onHomePageTapped;
  AppDrawer(
      {required this.onWebinarTapped,
      required this.onMockTestTapped,
      required this.onProfilePageTapped,
      required this.onHomePageTapped,
      });

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MockTest(),
    ChatPage(),
    WebinerPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name!, style: TextStyle(fontSize: 20.w)),
            accountEmail: Text(email!, style: TextStyle(fontSize: 16.w)),
            currentAccountPicture: pic != null
                ? Image.network(
                    pic!,
                    fit: BoxFit.fill,
                  )
                : CircleAvatar(
                    backgroundImage: AssetImage("assets/images/dp.jpg"),
                  ),
            decoration: BoxDecoration(
              color: Color(0xFFFF57100),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, size: 25.w),
            title: Text('Home', style: TextStyle(fontSize: 17.sp)),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: onHomePageTapped,
          ),
          ListTile(
            leading: Icon(Icons.book_online, size: 25.w),
            title: Text('Exam', style: TextStyle(fontSize: 17.sp)),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: onMockTestTapped,
            // onTap: () => {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => Note()),
            //   )
            // },
          ),
          ListTile(
            leading: Icon(Icons.computer, size: 25.w),
            title: Text('Webinar', style: TextStyle(fontSize: 17.sp)),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: onWebinarTapped,
          ),
          ListTile(
            leading: Icon(Icons.group, size: 25.w),
            title: Text('Team', style: TextStyle(fontSize: 17.sp)),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TeamPage()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.work, size: 25.w),
            title: Text('Jobs', style: TextStyle(fontSize: 17.sp)),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobPage()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone_outlined, size: 25.w),
            title: Text('Contact', style: TextStyle(fontSize: 17.sp)),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person, size: 25.w),
            title: Text('Profile', style: TextStyle(fontSize: 17.sp)),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            // onTap: () => {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => Home_Page()),
            //   )
            // },
            onTap: onProfilePageTapped,
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded, size: 25.w),
            title: Text('Logout', style: TextStyle(fontSize: 17.sp)),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: () {
              UserSimplePreferences.deleteAllData();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFF57100),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Version 1.0.0',
                      style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Developed by SYSCOGEN',
                      style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
