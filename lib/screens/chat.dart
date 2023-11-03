import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../main.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _controller = TextEditingController();
  List<ChatMessage> _messages = [];

  void getImageFromDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          messageContent: result.files.first.path!,
          messageType: MessageType.document,
          time: DateTime.now(),
        ));
      });
    }
  }

  Widget buildRow(String avatarText, String secondaryText) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      child: Padding(
        padding:  EdgeInsets.all(8.w),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 65.w,
                  height: 65.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      avatarText,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Technical team',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.w),
            Text(
              secondaryText,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildRow2(String avatarText, String secondaryText) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: Container(),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  avatarText,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          secondaryText,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Rima',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.blue[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Future getImageFromCamera() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _messages.add(ChatMessage(
            //messageContent: image.toString(),
            messageContent: image.path,
            messageType: MessageType.image,
            time: DateTime.now()));
      });
    }
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      // Check if image is not null
      setState(() {
        _messages.add(ChatMessage(
            //messageContent: image.toString(),
            messageContent: image.path,
            messageType: MessageType.image,
            time: DateTime.now()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          buildRow("Admin", "How can I help you?"),
          buildRow2("Yeh sure!","User"),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: _messages[index],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                              height: 120.h,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.photo_library),
                                        onPressed: () {
                                          getImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Text("Gallery", style: TextStyle(fontSize: 14.sp))
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.camera_alt),
                                        onPressed: () {
                                          getImageFromCamera();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Text("Camera", style: TextStyle(fontSize: 14.sp))
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          _messages.add(ChatMessage(
                            messageContent:
                            value, // Pass value instead of Text(value)
                            messageType: MessageType.text,
                            time: DateTime.now(),
                          ));
                          _controller.clear();
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {
                          return Container(
                            height: 200.h,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 10.h,),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.photo_library,size: 30.sp,color: Colors.green,),
                                      onPressed: () {
                                        getImageFromGallery();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(width: 10.w,),
                                    TextButton(
                                      onPressed: () {
                                        getImageFromGallery();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Gallery", style: TextStyle(fontSize: 15.sp,color: Colors.black)),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 6.h,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.camera_alt,size: 30.sp,color: Colors.purple,),
                                      onPressed: () {
                                        getImageFromCamera();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(width: 10.w,),
                                    TextButton(
                                      onPressed: () {
                                        getImageFromCamera();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Camera", style: TextStyle(fontSize: 15.sp,color: Colors.black)),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 6.h,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.document_scanner_outlined,size: 30.sp,color: Colors.blue,),
                                      onPressed: () {
                                        getImageFromDocument();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(width: 10.w,),
                                    TextButton(
                                      onPressed: () {
                                        getImageFromDocument();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Documents", style: TextStyle(fontSize: 15.sp,color: Colors.black)),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 6.h,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.attachment_outlined),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 27.sp,
                          ),
                          onPressed: () {
                            setState(() {
                              _messages.add(ChatMessage(
                                messageContent: _controller
                                    .text, // Pass _controller.text instead of Text(_controller.text)
                                messageType: MessageType.text,
                                time: DateTime.now(),
                              ));
                              _controller.clear();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40.sp,
          )
        ],
      ),
    );
  }
}

class ChatMessage {
  final String messageContent;
  final MessageType messageType;
  final DateTime time;

  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.time});
}

enum MessageType { text, image, document }

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.sp),
            child: CircleAvatar(
              child: Text("Me"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (message.messageType == MessageType.text)
                  Text(
                    message.messageContent,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                if (message.messageType == MessageType.image)
                  Container(
                    child: Image.file(File(message.messageContent)),
                  ),
                if (message.messageType == MessageType.document)
                  Container(
                    child: Text(
                      message.messageContent,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 5.sp),
                  child: Text(
                    "${message.time.hour}:${message.time.minute}",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
