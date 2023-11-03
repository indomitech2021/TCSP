import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saffety/utils/const.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/WebinarModel.dart';

class WebinarDetailPage extends StatelessWidget {
  final Webinar webinar;

  const WebinarDetailPage({required this.webinar});

  Future<void> launchMeetingLink() async {
    if (await canLaunch(webinar.link.toString())) {
      await launch(webinar.link.toString());
    } else {
      // If the Google Meet or Zoom app is not installed, launch the URL in a browser
      await launch(webinar.link.toString(), forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBlue,
        title: Text(webinar.title.toString()),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the details of the webinar here
              Text(webinar.title.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    width: 200.sp,
                    height: 210.sp,
                    child: Image.network(
                      "https://royadagency.com/images/webinar_images/${webinar.image}",
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(height: 60.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'DATE: ${webinar.timing}',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'TIME: 2:00PM',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.sp),
              Text(webinar.shortDescription.toString(),
                style: TextStyle(
                  fontSize: 14.h,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8.sp),
              Text(
                webinar.longDescription.toString(),
                style: TextStyle(
                  fontSize: 14.h,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 35.sp),
              Text(
                'Join below Link for this free webinar!',
                style: TextStyle(
                  fontSize: 14.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25.sp),
              GestureDetector(
                onTap: () {
                  launchMeetingLink();
                },
                child: Text(webinar.link.toString(),
                  style: TextStyle(
                    fontSize: 14.h,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}