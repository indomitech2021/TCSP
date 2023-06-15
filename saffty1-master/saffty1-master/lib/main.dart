import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saffety/screens/Mock_test.dart';
import 'package:saffety/screens/Webiner.dart';
import 'package:saffety/screens/chat.dart';
import 'package:saffety/screens/contact.dart';
import 'package:saffety/screens/home.dart';
import 'package:saffety/screens/job.dart';
import 'package:saffety/screens/main_page.dart';
import 'package:saffety/screens/note.dart';
import 'package:saffety/screens/profile.dart';
import 'package:saffety/screens/splash.dart';
import 'package:saffety/screens/team.dart';
import 'API/UserSimplePreferences.dart';
import 'login_screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child){
        return MaterialApp(
          supportedLocales: [
            const Locale('en'),
            const Locale('el'),
            const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
            const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
          ],
          localizationsDelegates: [
            CountryLocalizations.delegate,
         /*   GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,*/
          ],
          debugShowCheckedModeBanner: false,

          home: SplashScreen(),
        );
      },
    );

  }
}

class NavDrawer extends StatelessWidget {
  final VoidCallback onWebinarTapped; // Add this line
  String? email = UserSimplePreferences.getEmail() != null? UserSimplePreferences.getEmail().toString():"";
  String? name = UserSimplePreferences.getName() != null? UserSimplePreferences.getName().toString():"";
  String? pic = UserSimplePreferences.getPic() != null? "https://royadagency.com/images/user_images/"+UserSimplePreferences.getPic().toString():"";
  NavDrawer({required this.onWebinarTapped});
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name!, style: TextStyle(fontSize: 20.w)),
            accountEmail: Text(email!, style: TextStyle(fontSize: 16.w)),
            currentAccountPicture: pic!=null? Image.network(pic!,fit: BoxFit.fill,):
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/dp.jpg"),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFFF57100),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, size: 25.w),
            title: Text('Home', style: TextStyle(fontSize: 17.sp),),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: () => { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home_Page()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.note_add, size: 25.w),
            title: Text('Note', style: TextStyle(fontSize: 17.sp),),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Note()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.computer, size: 25.w),
            title: Text('Webinar', style: TextStyle(fontSize: 17.sp),),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: onWebinarTapped,
          ),
          ListTile(
            leading: Icon(Icons.group, size: 25.w),
            title: Text('Team', style: TextStyle(fontSize: 17.sp),),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TeamPage()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.computer_sharp, size: 25.w),
            title: Text('Jobs', style: TextStyle(fontSize: 17.sp),),
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
            title: Text('Contact', style: TextStyle(fontSize: 17.sp),),
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
            title: Text('Profile', style: TextStyle(fontSize: 17.sp),),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home_Page()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded, size: 25.w),
            title: Text('Logout', style: TextStyle(fontSize: 17.sp),),
            trailing: Icon(Icons.arrow_forward_ios, size: 25.w),
            onTap: ()  {
                     UserSimplePreferences.deleteAllData();
                     Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> LoginScreen(),));
    },
          ),
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFFF57100),
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 15.h,),
                Center(
                  child: Text(
                    'Developed by SYSCOGEN',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp ),
                  ),
                ),
              ],
            ),)
        ],
      ),
    );
  }
}