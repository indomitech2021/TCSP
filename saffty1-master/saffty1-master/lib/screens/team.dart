import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Team Member", style: TextStyle(fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildContainer(() {},),
              _buildContainer(() {},),
              _buildContainer(() {},),
              _buildContainer(() {},),
              _buildContainer(() {},),
              _buildContainer(() {},),
              _buildContainer(() {},),
            ],
          ),
        ),
      ),
    );
  }

    Widget _buildContainer(Function() onTap) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
            child: Material(
              elevation: 4.sp,
              child: Container(
                width: (MediaQuery.of(context).size.width - 40.0.w),
                height: 180.h,
                child: Column(
                  children: [
                    Row(
                        children: <Widget>[
                          Container(
                              width: 160.w,
                              height: 180.h,
                              child: Image.asset('assets/images/team.png',fit: BoxFit.cover,)
                          ),
                          SizedBox(width: 20.w,),
                          Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0.sp),
                                  child: Text(
                                    'Mr Bapi Sarkar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.0.sp,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3.0.sp),
                                  child: Text(
                                    'Team Leader',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0.sp,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3.0.sp),
                                  child: Text(
                                    'Safety Department',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0.sp,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3.0.sp),
                                  child: Text(
                                    '99999 99999',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0.sp,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3.0.sp),
                                  child: Text(
                                    'abcd@gmail.com',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0.sp,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.verified,color: Colors.blue,)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
}
