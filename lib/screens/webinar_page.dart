import 'dart:async';
import 'dart:convert';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../Models/WebinarsModelPast.dart';
import 'package:url_launcher/url_launcher.dart';

class PageWeb extends StatefulWidget {
  final String id;
  const PageWeb({Key? key, required this.id}) : super(key: key);

  @override
  State<PageWeb> createState() => _PageWebState();
}

class _PageWebState extends State<PageWeb> {
  static List<WebinarsModel> Webinarslist = [];
  bool noDataFound = false;
  late Timer _timer;

  Future<void> Webinars() async {
// String? id = UserSimplePreferences.getID() != null? UserSimplePreferences.getID().toString():"";
    final res = await http.post(
        Uri.parse("https://royadagency.com/API/Webinardetails.php"),
        body: <String, String>{
          'id': widget.id,
        });

    List lst;
    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        lst = data["webinars"];
        Webinarslist.clear();
        setState(() {
          for (int i = 0; i < lst.length; i++) {
            Map<String, dynamic> json = lst[i];
            Webinarslist.add(WebinarsModel(
              id: json['id'],
              title: json['title'],
              image: json['image'],
              short_description: json['short_description'],
              long_description: json['long_description'],
              timing: json['timing'],
              duration: json['duration'],
            ));
          }
        });
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

        print("error occurred");
        setState(() {
          noDataFound = true;
        });
      }
    }
  }

  String meetingLink =
      'https://meet.google.com/puf-fzvx-bqo'; // Replace with your actual meeting link

// Function to handle launching the meeting link
  Future<void> launchMeetingLink() async {
    if (await canLaunch(meetingLink)) {
      await launch(meetingLink);
    } else {
      // If the Google Meet or Zoom app is not installed, launch the URL in a browser
      await launch(meetingLink, forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      Webinars();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade400,
          title: Text('Webinar Details'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: !noDataFound
                ? Container(
                    child: Webinarslist.isNotEmpty
                        ? ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: Webinarslist.length,
                            itemBuilder: (context, index) {
                              return item(
                                i: index,
                                id: Webinarslist[index].id,
                                title: Webinarslist[index].title,
                                description:
                                    Webinarslist[index].short_description,
                                ldescription:
                                    Webinarslist[index].long_description,
                                timing: Webinarslist[index].timing,
                                image: Webinarslist[index].image,
                                expiration: Webinarslist[index].expiration,
                                duration: null,
                              );
                            },
                          )
                        : Center(child: CircularProgressIndicator()),
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
        ),
      ),
    );
  }

  Widget item(
      {required int i,
      required id,
      required title,
      required ldescription,
      required description,
      required expiration,
      required timing,
      required duration,
      required image}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      height: 900.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Text(
            Webinarslist[0].title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
                width: 200.w,
                height: 210.h,
                child: Image.network(
                  "https://royadagency.com/images/webinar_images/$image",
                  fit: BoxFit.fill,
                )),
          ),
          SizedBox(height: 60.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DATE: ${Webinarslist[0].timing}',
                  style: TextStyle(
                    fontSize: 16.h,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'TIME: 2:00PM',
                  style: TextStyle(
                    fontSize: 16.h,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60.h),
          Text(
            Webinarslist[0].short_description,
            style: TextStyle(
              fontSize: 14.h,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            Webinarslist[0].long_description,
            style: TextStyle(
              fontSize: 14.h,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 35.h),
          Text(
            'Join below Link for this free webinar!',
            style: TextStyle(
              fontSize: 14.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 25.h),
          GestureDetector(
            onTap: () {
              launchMeetingLink();
            },
            child: Text(
              meetingLink,
              style: TextStyle(
                fontSize: 14.h,
                color: Colors.grey,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Meeting ID: 8643266885378',
            style: TextStyle(
              fontSize: 14.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Password: 8754345677',
            style: TextStyle(
              fontSize: 14.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
