import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saffety/screens/succesful.dart';
import 'package:http/http.dart' as http;

import '../Models/JobsMode.dart';

class JobDetails extends StatefulWidget {
  final String id;
  const JobDetails({Key? key, required this.id}) : super(key: key);


  @override
  State<JobDetails> createState() => _JobDetailsState();
}
class _JobDetailsState extends State<JobDetails> {
  static List<JobsModel> Jobslist = [];
  bool noDataFound = false;
  late Timer _timer;

  Future<void> Jobs() async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/Jobdetails.php"),
        body: <String, String>{
          'id': widget.id,
        });

    List lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        lst = data["jobs"];
        Jobslist.clear();
        setState(() {
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
                experience: json['experience'],
                description: json['description'],
                responsibilities: json['responsibilities'],
                skills: json['skills']
            ));
          }
        });
        print("success");
      }
      else {
        print(data["message"]);
        Fluttertoast.showToast(
            msg: data["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        noDataFound = true;
        print("error occurred");
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      Jobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:
          Container(
            child: !noDataFound
                ? Container(
              child: Jobslist.isNotEmpty
                  ? ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: Jobslist.length,
                itemBuilder: (context, index) {
                  return item(
                    i: index,
                    id: Jobslist[index].id,
                    title: Jobslist[index].title,
                    company_name: Jobslist[index].company_name,
                    company_logo: Jobslist[index].company_logo,
                    description: Jobslist[index].description,
                    job_type: Jobslist[index].job_type,
                    experience: Jobslist[index].experience,
                    salary: Jobslist[index].salary,
                    location: Jobslist[index].location,
                    responsibilities: Jobslist[index].responsibilities,
                    skills: Jobslist[index].skills,
                  );
                },
              )
                  : Center(child: CircularProgressIndicator()),
            )
                : Column(
              children: [
                Center(
                    child: Image.asset("assets/img/one.webp")
                ),
                Text("No Data Found", style: TextStyle(
                    fontSize: 20, color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item({required int i,
    required id,
    required title,
    required company_name,
    required company_logo,
    required experience,
    required description,
    required salary,
    required location,
    required job_type,
    required responsibilities,
    required skills
  }) {
    return
    Column(
      children: [
        Container(
          width: double.infinity,
          height: 306.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 25.sp,
              ),
              Text(Jobslist[0].title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D0D26),
                ),
              ),
              SizedBox(height: 20.h),
              CircleAvatar(
                child: Image.asset(
                  'assets/images/fb.png',
                  height: 200.h,
                  width: 200.w,
                ),
                radius: 40.r,
              ),
              Text('$title',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D0D26),
                ),
              ),
              Text('$company_name',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D0D26),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20.r,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: Text('$job_type',
                          style: TextStyle(
                              fontSize: 13.sp, color: Colors.black),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20.r,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Text('Location',
                          style: TextStyle(
                              fontSize: 13.sp, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          size: 20.sp,
                        ),
                        Text('$salary',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('$location',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0.w),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D0D26),
                  ),
                ),
                SizedBox(height: 15.h,),
                Text('$description',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF494A50),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Responsibilities:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF494A50),
                  ),
                ),
                SizedBox(height: 15.h,),
                Text("$responsibilities",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF494A50),
                  ),
                ),
                SizedBox(height: 8.h,),
                Text("Skills",
                  style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: Color(0xFF494A50),
                  ),
                ),
                SizedBox(height: 8.h,),
                Text("$skills",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF494A50),
                  ),
                ),

              ],
            ),
          ),
        ),
        SizedBox(height: 50.h,),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SuccessfulPage()),
            );
          },
          child: Container(
            width: 327.w,
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              color: Color(0xFF0058AC),
            ),
            child: Center(child: Text('Apply Now',
              style: TextStyle(color: Colors.white, fontSize: 16.sp),)),
          ),
        ),
      ],
    );
  }
}

