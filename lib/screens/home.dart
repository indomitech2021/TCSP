import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:saffety/screens/Mock_test.dart';
import 'package:saffety/screens/WebinerPage.dart';
import 'package:saffety/screens/job.dart';
import 'package:saffety/screens/job_details.dart';
import 'package:saffety/screens/quizquestion.dart';
import 'package:saffety/screens/webinar_page.dart';
import '../Models/JobsMode.dart';
import '../Models/WebinarsModelPast.dart';
import '../Provider/appProvider.dart';
import '../main.dart';
import '../utils/Tile/ExamDetailsTile.dart';
import '../utils/Tile/WebinarTile.dart';
import '../utils/widgets/AppDrawer.dart';
import 'WebinarDetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
  Future<void> Jobs() async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res =
        await http.post(Uri.parse("https://royadagency.com/API/Jobs.php"));

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
              salary: json['salary'],
              experience: json['experience']));
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

  //________Webinars
  Future<void> Webinars() async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res =
        await http.post(Uri.parse("https://royadagency.com/API/Webinars.php"));

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
      backgroundColor: const Color.fromRGBO(250, 250, 253, 1),
      //drawer: NavDrawer(onWebinarTapped: () {  },),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
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
              padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Recent Job',
                      style: TextStyle(
                          fontSize: 13.sp, color: Colors.blue.shade700),
                    ),
                  ),

                  Consumer<AppProvider>(builder: (context,provider,child){
                    return TextButton(
                      onPressed: () {
                        provider.setCurrentPageIndex(1);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => JobPage()),
                        // );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 13.sp, color: Colors.blue.shade700),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Container(
              height: 200.sp,
              color: Colors.transparent,
              //width: 300,
              child: Jobslist.isNotEmpty
                  ? ListView.builder(
                  // physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.all(10.sp),
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: Jobslist.length,
                  itemBuilder: (context, index) {
                    return RecentJobTile(
                      job: Jobslist[index],
                    );
                  })
                  : Text(""),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Exam',
                    style: TextStyle(
                        fontSize: 13.sp, color: Colors.blue.shade700),
                  ),
                  Consumer<AppProvider>(builder: (context,provider,child){
                    return TextButton(
                      onPressed: () {
                        provider.setCurrentPageIndex(1);
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 13.sp, color: Colors.blue.shade700),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Consumer<AppProvider>(
              builder: (context, provider, child) {
                return SizedBox(
                  height: 130.h,
                  child: ListView.builder(
                      itemCount: provider.exams.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TestQuestionPage(
                                  exam: provider.exams[index],
                                )),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: ExamDetailsTile(
                                exam: provider.exams[index],
                              ),
                            ));
                      }),
                );
              },
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Webiner',
                      style: TextStyle(
                          fontSize: 13.sp, color: Colors.blue.shade700),
                    ),
                  ),
                  Consumer<AppProvider>(builder: (context,provider,child){
                    return TextButton(
                      onPressed: () {
                        provider.setCurrentPageIndex(3);
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 13.sp, color: Colors.blue.shade700),
                      ),
                    );
                  }),
                ],
              ),
            ),

            SizedBox(
              height: 200.sp,
              child: const HomeWebinarTile(),
            ),
            Container(
              height: 30.sp,
            )


          ],
        ),
      ),
    );
  }
}





class HomeWebinarTile extends StatefulWidget {
  const HomeWebinarTile({Key? key}) : super(key: key);

  @override
  State<HomeWebinarTile> createState() => _HomeWebinarTileState();
}

class _HomeWebinarTileState extends State<HomeWebinarTile> {
  late AppProvider appProvider;

  @override
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.fetchWebinars();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: appProvider.isLoading
          ?  Center(
        child: Lottie.asset(
          'assets/Animation/loadingAnimation.json', // Replace with the path to your Lottie animation file
          width: 150, // Adjust the width and height as needed
          height: 150,
        ),
      )
          : appProvider.errorMessage.isNotEmpty
          ? Center(
        child: Text(appProvider.errorMessage),
      )
          : ListView.builder(
        //padding: EdgeInsets.all(10.sp),
        itemCount: appProvider.webinars.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final webinar = appProvider.webinars[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebinarDetailPage(
                  webinar: webinar,
                )),
              );
            },
            child: WebinarTile(webinar: webinar,),
          );
        },
      ),
    );
  }
}



class RecentJobTile extends StatelessWidget {
  RecentJobTile({
    required this.job,
    Key? key}) : super(key: key);

  JobsModel job;

  @override
  Widget build(BuildContext context) {
    return (job == null)? Lottie.asset(
      'assets/Animation/loadingAnimation.json', // Replace with the path to your Lottie animation file
      width: 150, // Adjust the width and height as needed
      height: 150,
    ) : Material(
      elevation: 4,
      child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      JobDetails(id: job.id)),
            );
          },
          child: Container(
            width: 340.sp,
            height: 200.sp,
            margin: EdgeInsets.only(right: 15.sp),
            padding: EdgeInsets.symmetric(vertical: 25.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x00000040),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              //clockIcon
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60.sp,
                        width: 60.sp,
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/fb.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.sp,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text(
                            job.title,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 17.sp,
                              color:
                              Colors.blue.shade800,
                            ),
                          ),
                          SizedBox(height: 5.sp,),
                          Text(
                            job.company_name,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ]),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 38.sp,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Row(
                            children: [
                              Lottie.asset(
                                'assets/Animation/clockIcon.json', // Replace with the path to your Lottie animation file// Adjust the width and height as needed
                                height: 28,
                              ),
                              // Icon(
                              //   Icons.more_time_outlined,
                              //   color: Colors.grey.shade700,
                              // ),
                              SizedBox(width: 8.sp),
                              Text(
                                job.job_type,
                                style: TextStyle(
                                    color:
                                    Colors.grey.shade600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Lottie.asset(
                              //   'assets/Animation/inr.json', // Replace with the path to your Lottie animation file
                              //   //width: 100, // Adjust the width and height as needed
                              //   height: 25.sp,
                              // ),
                              Icon(
                                Icons.currency_rupee,
                                color: Colors.grey.shade700,
                              ),
                              SizedBox(width: 8.w),
                              Text(job.salary,
                                  style: TextStyle(
                                      color: Colors
                                          .grey.shade600)),
                            ],
                          ),


                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            //location_Icon
                            children: [
                              Lottie.asset(
                                'assets/Animation/location_Icon.json', // Replace with the path to your Lottie animation file
                                //width: 100, // Adjust the width and height as needed
                                height: 28.sp,
                              ),
                              // Icon(
                              //   Icons.location_on,
                              //   color: Colors.grey.shade700,
                              // ),
                              SizedBox(width: 8.sp),
                              Text(job.location,
                                  style: TextStyle(
                                      color: Colors
                                          .grey.shade600)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.call_to_action_outlined,
                                color: Colors.grey.shade700,
                              ),
                              SizedBox(width: 8.w),
                              Text(job.experience,
                                  style: TextStyle(
                                      color: Colors
                                          .grey.shade600)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )

              ],
            ),
          )),
    );
  }
}


class HomeExamTile extends StatelessWidget {
  const HomeExamTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}















