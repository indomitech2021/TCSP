import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_page.dart';

class EnquiryPage extends StatefulWidget {
  const EnquiryPage({Key? key}) : super(key: key);

  @override
  State<EnquiryPage> createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<EnquiryPage> {
  String? _selectedOption;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp, // added fontsize in sp
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w), // added padding in width
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h), // added height in height
                Text(
                  'Enquiry Form',
                  style: TextStyle(
                    fontSize: 20.sp, // added fontsize in sp
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D0D26),
                  ),
                ),
                SizedBox(height: 50.h), // added height in height
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp), // added border-radius in sp
                    ),
                    hintText: 'Miss Najema',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20.h), // added height in height
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp), // added border-radius in sp
                    ),
                    hintText: 'Email Id',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                SizedBox(height: 20.h), // added height in height
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp), // added border-radius in sp
                    ),
                    hintText: 'Subject',
                    prefixIcon: Icon(Icons.menu),
                  ),
                ),
                SizedBox(height: 20.h), // added height in height
                TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.sp), // added border-radius in sp
                    ),
                    hintText: 'Message',
                    // prefixIcon: Icon(Icons.menu),
                  ),
                ),
                SizedBox(height: 73.h), // added height in height
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home_Page()),
                    );
                  },
                  child: Container(
                    width: 327.w, // added width in width
                    height: 56.h, // added height in height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp), // added border-radius in sp
                      color: Color(0xFF0058AC),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp, // added fontsize in sp
                          height: 1.5.h, // added line-height in height
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h), // added height in height
              ],
            ),
          ),
        ),
      ),
    );
  }
}
