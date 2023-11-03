import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saffety/screens/cvfinal.dart';
import '../API/UserSimplePreferences.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UploadResumePage extends StatefulWidget {
  @override
  _UploadResumePageState createState() => _UploadResumePageState();
}

class _UploadResumePageState extends State<UploadResumePage> {
  // Declare a variable to store the selected file path
  String? _filePath;
  String? filename;
  late PlatformFile file;

  // Define a function to handle file selection
  void _selectFile() async {
    // Use file picker package to select a file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc']
    );
    if (result != null) {
      setState(() {
         _filePath = result.files.single.path!;
         file = result.files.first;
         filename=file.name;
         print(file.name);
      });
    }
    }
   Future<dynamic> uploadfile(String email, PlatformFile file, String token) async {
    var fileName = file.path?.split('/').last;
    print(fileName);
    var formData = FormData.fromMap({
      'email':email,
      'title': 'Upload Dokumen',
      'uploaded_file': await MultipartFile.fromFile(file.path!,
          filename: fileName, contentType: MediaType('application', 'pdf')),
      "type": "application/pdf"
    });


    var response = await Dio().post('https://royadagency.com/API/upload_resume.php',
        options: Options(
            contentType: 'multipart/form-data',
            headers: {HttpHeaders.authorizationHeader: 'Token $token'}),
        data: formData);
    var data = json.decode(response.toString()); //decoding json to array
    if (data["error"]) {
      Navigator.push(context,MaterialPageRoute(builder: (context) => CvFinal()),
      );
      print(response);
      return response;
    }
    else
      {
        print(response);
        return response;
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Upload Resume or CV', style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.h, vertical: 15.0.h),
            child: Container(
              padding: EdgeInsets.all(12.0.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Upload your CV or resume and use it when you apply for jobs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 70.0.h),
                    _filePath != null
                        ? Text('Selected file: $filename', style: TextStyle(fontSize: 16.0.sp))
                        : Container(),
                    SizedBox(height: 16.0.h),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 10.0.h),
                        child: Text(
                          'Upload A Doc/PDF',
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                      onPressed: _selectFile,
                    ),
                    SizedBox(height: 50.0.h),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0.w, vertical: 10.0.h),
                        child: Text(
                          'Upload',
                          style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        String? email = UserSimplePreferences.getEmail() != null ? UserSimplePreferences.getEmail().toString() : "";
                        uploadfile(email, file, "1234");
                       /* Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CvFinal()),
                        );*/
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}