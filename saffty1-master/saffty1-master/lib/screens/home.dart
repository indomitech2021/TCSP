import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saffety/screens/Mock_test.dart';
import 'package:saffety/screens/Webiner.dart';
import 'package:saffety/screens/job.dart';
import 'package:saffety/screens/job_details.dart';
import 'package:saffety/screens/quizquestion.dart';
import 'package:saffety/screens/webinar_page.dart';
import '../Models/JobsMode.dart';
import '../Models/WebinarsModel.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool _isFollowing = false;
  String operatingSystem = Platform.operatingSystem;
  static List<JobsModel> Jobslist = [];
  static List<WebinarsModel> Webinarslist = [];
  final PageController _controller = PageController(initialPage: 0);
  late Timer _timer;
  int _currentPage = 0;
  bool isLastPage = false;

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

//--------------------------Jobs
  Future<void>  Jobs() async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/Jobs.php"));

    List lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        lst = data["jobs"];

        for (int i = 0; i < lst.length; i++) {
          Map<String, dynamic> json = lst[i];
          Jobslist.add(JobsModel(
              id: json['id'],
              title: json['title'],
              job_type: json['job_type'],
              company_name: json['company_name'],
              company_logo: json['company_log'],
              location: json['location'],
              salary:json['salary'],
              experience: json['experience']
          ));
        }
        print("success");
      }
      else
      {
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
  //________Webinars
  Future<void>  Webinars() async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/Webinars.php"));

    List lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        lst = data["webinars"];

        for (int i = 0; i < lst.length; i++) {
          Map<String, dynamic> json = lst[i];
          Webinarslist.add(WebinarsModel(
              id: json['id'],
              title: json['title'],
              image: json['image'],
              short_description: json['short_description'],
              timing: json['timing'],
              duration: json['duration'],
          ));
        }
        print("success");
      }
      else
      {
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

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {}
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
    Jobs();
    Webinars();
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: NavDrawer(onWebinarTapped: () {  },),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth.w,
          child: Column(
            children: [
              Container(
                height: _height * 0.25.h,
                child: PageView(
                  controller: _controller,
                  children: [
                    Image.asset('assets/images/slide1.png', fit: BoxFit.cover),
                    Image.asset('assets/images/slide2.png', fit: BoxFit.cover),
                    Image.asset('assets/images/slide3.png', fit: BoxFit.cover),
                  ],
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                      isLastPage = page == 2;
                    });
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Recent Job',
                        style: TextStyle(fontSize: 13.sp, color: Colors.blue.shade700),
                      ),
                    ),
                    TextButton(
                      onPressed: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JobPage()),
                      );},
                      child: Text(
                        'See All',
                        style: TextStyle(fontSize: 13.sp, color: Colors.blue.shade700),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  Container(
                    height: 150,
                    width: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:
                        Jobslist.isNotEmpty?
                        ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                        itemCount: Jobslist.length,
                        itemBuilder: (context, index) {
                    return Material(
                      elevation: 4,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JobDetails(id:Jobslist[index].id)),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40.0.w,
                          height: 200.h,
                          padding: EdgeInsets.all(16.0.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: AssetImage('assets/images/fb.png'),
                                        radius: 30.0.r,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(Jobslist[index].title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0.sp,
                                              color: Colors.blue.shade800,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0.w),
                                            child: Text(Jobslist[index].company_name,
                                   style: TextStyle(
                                     color: Colors.grey,
                                     fontSize: 16.sp,
                                   ),
                                 ),
                               ),
                             ],
                           ),]
       ),
                 ),
                         Padding(
                           padding:  EdgeInsets.all(5.sp),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Row(
                                 children: [
                                   Icon(Icons.more_time_outlined,color: Colors.grey.shade700,),
                                   SizedBox(width: 8.w),
                                   Text(Jobslist[index].job_type,style: TextStyle(color: Colors.grey.shade600),),
                                 ],
                               ),
                               Row(
                                 children: [
                                   Icon(Icons.location_on,color: Colors.grey.shade700,),
                                   SizedBox(width: 8.w),
                                   Text(Jobslist[index].location,style: TextStyle(color: Colors.grey.shade600)),
                                 ],
                               ),
                             ],
                           ),
                         ),
                         Padding(
                           padding:  EdgeInsets.all(5.sp),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               Row(
                                 children: [
                                   Icon(Icons.currency_rupee,color: Colors.grey.shade700,),
                                   SizedBox(width: 8.w),
                                   Text(Jobslist[index].salary,style: TextStyle(color: Colors.grey.shade600)),
                                 ],
                               ),

                               Row(
                                 children: [
                                   Icon(Icons.call_to_action_outlined,color: Colors.grey.shade700,),
                                   SizedBox(width: 8.w),
                                   Text(Jobslist[index].experience,style: TextStyle(color: Colors.grey.shade600)),
                                 ],
                               ),
                             ],
                           ),
                         ),
                     ],
                 ),
                     )
                      ),
                    );
                     })
                       :Text(""),
               ),
                  ),
                   Padding(
                     padding:  EdgeInsets.symmetric(horizontal: 10.w),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         TextButton(
                           onPressed: () {},
                           child: Text('Quiz',style: TextStyle(fontSize: 13.sp,color: Colors.blue.shade700),),
                         ),
                         TextButton(
                           onPressed: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => MockTest()),
                             );
                           },
                           child: Text('See All',style: TextStyle(fontSize: 13.sp,color: Colors.blue.shade700),),
                         ),
                       ],
                     ),
                   ),
                   Material(
                     elevation: 4,
                     child: GestureDetector(
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => GKQuizPage()),
                         );
                       },
                       child: Container(
                         width: MediaQuery.of(context).size.width - 40.w,
                         height: 130.h,
                         child: Column(
                           children: [
                             Row(
                                 children: <Widget>[
                                   Container(
                                     width: 100.w,
                                     height: 130.h,
                                     child: Image.asset('assets/images/quiz.png',fit: BoxFit.cover,)
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.all(8.w),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Padding(
                                           padding:  EdgeInsets.all(8.w),
                                           child: Text(
                                             'GK Mock Test',
                                             style: TextStyle(
                                               fontWeight: FontWeight.w600,
                                               fontSize: 17.sp,
                                               color: Colors.blue.shade800,
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding:  EdgeInsets.all(8.w),
                                           child: Row(
                                             children: [
                                               Icon(Icons.format_list_numbered_outlined,color: Colors.grey.shade700,size: 20.sp,),
                                               SizedBox(width: 10.w,),
                                               Text(
                                                 '5 Question',
                                                 style: TextStyle(
                                                   color: Colors.grey,
                                                   fontSize: 15.sp,
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                         Padding(
                                           padding:  EdgeInsets.all(8.w),
                                           child: Row(
                                             children: [
                                               Icon(Icons.timelapse_rounded,color: Colors.grey.shade700,size: 20.w,),
                                               SizedBox(width: 10.w,),
                                               Text(
                                                 '30 min',
                                                 style: TextStyle(
                                                   color: Colors.grey,
                                                   fontSize: 15.sp,
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),]
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                   SizedBox(height: 10.h),
                   Container(
                     width: MediaQuery.of(context).size.width - 40.w,
                     height: 100.h,
                     color: Colors.white,
                     child: Image.asset('assets/images/add.png',fit: BoxFit.cover,),
                   ),
                   Padding(
                     padding:  EdgeInsets.symmetric(horizontal: 10.h),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         TextButton(
                           onPressed: () {

                           },
                           child: Text('Webiner',style: TextStyle(fontSize: 13.sp,color: Colors.blue.shade700),),
                         ),
                         TextButton(
                           onPressed: () {Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => WebinerPage()),
                           );},
                           child: Text('See All',style: TextStyle(fontSize: 13.sp,color: Colors.blue.shade700),),
                         ),
                       ],
                     ),
                   ),
                         Container(
                          height: 180,
                         width: 290,
                        child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                            Webinarslist.isNotEmpty?
                            ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                            itemCount: Webinarslist.length,
                          itemBuilder: (context, index) {
                          return
                          Material(
                    elevation: 4,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageWeb(id:Webinarslist[0].id)),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40.w,
                        height: 210.h,
                        child: Column(
                          children: [
                            Row(
                                children: <Widget>[
                                  Container(
                                      width: 130.w,
                                      height:150.h,
                                      child: Image.network("https://royadagency.com/images/webinar_images/${Webinarslist[0].image}",fit: BoxFit.fill,)
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.all(8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 8.h),
                                          child: Text(Webinarslist[index].title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:180,
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(vertical: 5.h),
                                            child: Text(Webinarslist[index].short_description,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 3.h),
                                          child: Row(
                                            children: [
                                              Icon(Icons.calendar_month,color: Colors.grey.shade700,size: 18.sp,),
                                              SizedBox(width: 15.w,),
                                              Text("DATE: ${Webinarslist[index].timing}",
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 3.h),
                                          child: Row(
                                            children: [
                                              Icon(Icons.timelapse_rounded,color: Colors.grey.shade700,size: 15.sp,),
                                              SizedBox(width: 15.w,),
                                              Text('TIME: 2:00 PM',
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 8.h),
                                          child: Text('Duration: ${Webinarslist[index].duration}',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),]
                            ),
                          ],
                        ),
                      ),
                    ),
                          );
                          })
                                :Text(""),
                        ),
                         ),
                 ],
               ),
             ],
           ),
         ),
       ),
    );
  }
}
