import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Models/ExamModel.dart';


class ExamDetailsTile extends StatelessWidget {
  ExamDetailsTile({required this.exam, Key? key}) : super(key: key);

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.sp),
          child: Material(
            elevation: 4,
            child: GestureDetector(
              // onTap: onTap,
              child: Container(
                width: (MediaQuery.of(context).size.width - 40.w),
                height: 110.h,
                child: Column(
                  children: [
                    Row(children: <Widget>[
                      Container(
                        width: 100.w,
                        height: 110.h,
                        child: Image.asset(
                          'assets/images/quiz.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Text(
                                exam.name.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.sp,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.sp),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.format_list_numbered_outlined,
                                    color: Colors.grey.shade700,
                                    size: 20.sp,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    '${exam.mcqs.length} Question',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.sp),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.timelapse_rounded,
                                    color: Colors.grey.shade700,
                                    size: 20.sp,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    '${exam.duration} min',
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
        ),
      ],
    );
  }
}

