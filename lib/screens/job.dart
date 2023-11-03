import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../Models/JobsMode.dart';
import 'job_details.dart';

class JobPage extends StatefulWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  static List<JobsModel> Jobslist = [];
  bool noDataFound = false;
  Future<void> Jobs() async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res =
        await http.post(Uri.parse("https://royadagency.com/API/Jobs.php"));
    List lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        Jobslist.clear();
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
        noDataFound = true;
        print("error occurred");
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Jobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0058AC),
        centerTitle: true,
        title: Text(
          "Result (${Jobslist.length})",
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list_sharp),
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildContainer(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JobDetails(id: "0")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(Function() onTap) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                                responsibilities:
                                    Jobslist[index].responsibilities,
                                skills: Jobslist[index].skills,
                              );
                            },
                          )
                        :  Center(
                      child: Lottie.asset(
                        'assets/Animation/loadingAnimation.json', // Replace with the path to your Lottie animation file
                        width: 150, // Adjust the width and height as needed
                        height: 150,
                      ),
                    )
                  )
                : Column(
                    children: [
                      Center(child: Image.asset("assets/img/one.webp")),
                      Text(
                        "No Data Found",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget item(
      {required int i,
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
      required skills}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Material(
        elevation: 4,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobDetails(id: id)),
            );
          } //onTap(),
          ,
          child: Container(
            width: MediaQuery.of(context).size.width - 40.w,
            height: 200.h,
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/fb.png'),
                          radius: 30.r,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '$title',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Text(
                                '$company_name',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.more_time_outlined,
                            color: Colors.grey.shade700,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '$job_type',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey.shade700,
                          ),
                          SizedBox(width: 8.w),
                          Text('$location',
                              style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.currency_rupee,
                            color: Colors.grey.shade700,
                          ),
                          SizedBox(width: 8.w),
                          Text('$salary',
                              style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.call_to_action_outlined,
                            color: Colors.grey.shade700,
                          ),
                          SizedBox(width: 8.w),
                          Text('$experience',
                              style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
