import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saffety/screens/main_page.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  String? _selectedOption;
  TextEditingController _controller = TextEditingController();

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.getImage(source: source);

      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } on PlatformException catch (e) {
      print('Image picker error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              Text(
                'Profile Update',
                style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D0D26),
                ),
              ),
              SizedBox(height: 15.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 60.r,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.add_a_photo_outlined,size: 37.sp,) : null,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:  Text('Choose an image'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  GestureDetector(
                                    child:  Text('Camera'),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      _pickImage(ImageSource.camera);
                                    },
                                  ),
                                   SizedBox(height: 16.h),
                                  GestureDetector(
                                    child:  Text('Gallery'),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      _pickImage(ImageSource.gallery);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child:  Text('Update Image',style: TextStyle(fontSize: 18),),
                  ),
                  Icon(Icons.add_circle_outline_outlined,color: Colors.blue.shade700,)
                ],
              ),            ],
      ),
              SizedBox(height: 30.h),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  hintText: 'Miss Najema',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  hintText: 'Mobile Number',
                  prefixIcon: Icon(Icons.pin_drop),
                  prefix: Text('+91'),
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  hintText: 'Email Id',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  hintText: 'Address',
                  prefixIcon: Icon(Icons.location_city),
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  hintText: 'Qualification',
                  prefixIcon: Icon(Icons.school),
                  suffixIcon: DropdownButton<String>(
                    value: _selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue;
                        _controller.text = _selectedOption ?? '';
                      });
                    },
                    items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home_Page()),
                  );
                },
                child: Container(
                  width: 327.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: Color(0xFF0058AC),
                  ),
                  child: Center(child: Text('Update ',style: TextStyle(color: Colors.white,fontSize: 16.sp),)),
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    ));
  }
}
