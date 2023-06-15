import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saffety/screens/webinar_page.dart';

import '../Models/WebinarsModel.dart';
import 'package:http/http.dart' as http;

class WebinerPage extends StatefulWidget {
  const WebinerPage({Key? key}) : super(key: key);

  @override
  State<WebinerPage> createState() => _WebinerPageState();
}

class _WebinerPageState extends State<WebinerPage> {
  static List<WebinarsModel> Webinarslist = [];
  bool noDataFound = false;
  //________Webinars
  Future<void>  Webinars() async {
    print("hello");
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
        setState(() {
          noDataFound=true;
        });

      }
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),
              Text('Recent Webiner',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16.sp),),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildContainer(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WebinerPage()),
                    );
                  },),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildContainer(Function() onTap) {
    return Column(
      children: [
    Container(
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
          description: Webinarslist[index].short_description,
          ldescription: Webinarslist[index].long_description,
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
    Center(
    child: Image.asset("assets/img/one.webp")
    ),
    Text("No Data Found", style: TextStyle(
    fontSize: 20, color: Colors.white),)
    ],
    ),
    ),
      ],
    );
  }

  Widget item({required int i,
    required id,
    required title,
    required ldescription,
    required description,
    required expiration,
    required timing,
    required duration,
    required image
  }) {
  return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: Material(
        elevation: 4,
        child: GestureDetector(
          onTap:() {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageWeb(id: id)),
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
                          height: 210.h,
                          child: Image.network("https://royadagency.com/images/webinar_images/$image",fit: BoxFit.fill,)
                      ),
                      Padding(
                        padding:  EdgeInsets.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(Webinarslist[0].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 5.h),
                                child: Text(description,
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
                                  Text('DATE: ${timing}',
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
                              child: Text('Duration:${duration}',
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
          )
      ),
    ),);
  }
}

