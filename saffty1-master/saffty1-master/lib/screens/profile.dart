import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:saffety/screens/cvfinal.dart';
import 'package:saffety/screens/privacypolicy.dart';
import 'package:saffety/screens/profileupdate.dart';
import 'package:saffety/screens/tearmcondition.dart';
import "package:async/async.dart";
import 'package:path/path.dart';
import 'dart:io';
import '../API/UserSimplePreferences.dart';
import 'changepassword.dart';
import 'cv.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.person_add_rounded, 'text': 'Edit Account Details'},
    {'icon': Icons.password, 'text': 'Change Password'},
    {'icon': Icons.update, 'text': 'Update CV or Resume'},
    {'icon': Icons.share, 'text': 'Share App'},
    {'icon': Icons.terminal_sharp, 'text': 'Terms & Conditions'},
    {'icon': Icons.note_add, 'text': 'Privacy Policy'},
  ];
  bool permissionGranted = false;
  List<ByteData> mainByteDataFile = [];
  List<Asset> selectedAssets = [];
  bool imgfound=false;
  String img="";
  String? name="";
  ImagePicker picker = ImagePicker();
  File? image;


  Future addProfilePic(File imageFile) async {
    String? email = UserSimplePreferences.getEmail() != null ? UserSimplePreferences.getEmail().toString() : "";
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://royadagency.com/API/profile_image.php");
   // var request = new http.MultipartRequest("POST", uri);
    var request=http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path));
    request.files.add(multipartFile);
    request.fields['email'] = email;

    var respond = await request.send();
    if (respond.statusCode == 200) {

      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
  }

  Future<void>  FetchProfilePic() async {
    String? email = UserSimplePreferences.getEmail() != null? UserSimplePreferences.getEmail().toString():"";
  final res = await http.post(
  Uri.parse("https://royadagency.com/API/fetchProfilePic.php"),
  body: <String, String>{
  'email':email
  });
  List lst;
  if (res.statusCode == 200) {
  print(res.body); //print raw response on console
  var data = json.decode(res.body); //decoding json to array
  if (data["error"])
  {
    setState(() {
      img="https://royadagency.com/images/user_images/"+data["message"];
    });
  }
  else
  {
  Fluttertoast.showToast(
  msg: data["message"],
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.CENTER,
  timeInSecForIosWeb: 1,
  textColor: Colors.white,
  fontSize: 16.0
  );
  }
  }
}

  @override
  void initState() {
    setState(() {
      FetchProfilePic();
      name = UserSimplePreferences.getName() != null ? UserSimplePreferences.getName().toString() : "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            GestureDetector(
              onTap: () async {
                  XFile?  img = await picker.pickImage(source: ImageSource.gallery);
                  image = File(img!.path);
                    setState(() {
                      image = image;
                    });
                    addProfilePic(image!);
                    },
              child:
              CircleAvatar(
                radius: 57,
                backgroundColor: Color(0xff476cfb),
                child: ClipOval(
                  child: new SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: (image != null)
                        ? Image.file(image!,
                      fit: BoxFit.fill,
                    )
                        : Image.network(img,fit: BoxFit.fill,),
                  ),
                ),
              ),),
            SizedBox(height: 20.h),
            Text('$name',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50.h),
            ..._items.map((item) => Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (item['text'] == 'Edit Account Details') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileUpdate()),
                          );
                        } else if (item['text'] == 'Change Password') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChangePassword()),
                          );
                        } else if (item['text'] == 'Update CV or Resume') {
                           if(UserSimplePreferences.getResume().toString()=="") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UploadResumePage()),
                            );
                          }
                          else
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CvFinal()),
                              );
                            }
                        } else if (item['text'] == 'Share App') {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SharePage()),
                          // );
                        } else if (item['text'] == 'Terms & Conditions') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TermCondition()),
                          );
                        } else if (item['text'] == 'Privacy Policy') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 13.0.h),
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                item['icon'],
                                color: Colors.grey.shade900,
                              ),
                              SizedBox(width: 20.w),
                              Text(
                                item['text'],
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade800,
                    ),
                  ]),
            )),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );  }
}
