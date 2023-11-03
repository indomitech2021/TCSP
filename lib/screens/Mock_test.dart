import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:saffety/Models/ExamModel.dart';
import 'package:saffety/screens/quizquestion.dart';

import '../Provider/appProvider.dart';
import '../utils/Tile/ExamDetailsTile.dart';

class MockTest extends StatefulWidget {
  const MockTest({Key? key}) : super(key: key);

  @override
  State<MockTest> createState() => _MockTestState();
}

// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => GKQuizPage()),
// );

class _MockTestState extends State<MockTest> {
  @override
  void initState() {
    super.initState();
    // Call the fetchExamData function when the widget is first loaded
    Provider.of<AppProvider>(context, listen: false).fetchExamData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Exam Details",
            style: TextStyle(
              fontSize: 16.h,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          // leading: GestureDetector(
          //   onTap: (){
          //     Navigator.pop(context);
          //   },
          //   child: const Icon(Icons.arrow_back_ios,
          //     color: Colors.black,
          //   ),
          // ),
        ),
        body: Consumer<AppProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
                itemCount: provider.exams.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TestQuestionPage(
                          exam: provider.exams[index],
                        )),
                        );
                      },
                      child: ExamDetailsTile(
                        exam: provider.exams[index],
                      ));
                });
          },
        ));
  }
}
