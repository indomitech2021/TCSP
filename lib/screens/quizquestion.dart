import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saffety/screens/quizresult.dart';

import '../Models/ExamModel.dart';

class TestQuestionPage extends StatefulWidget {
  final Exam exam;

  TestQuestionPage({required this.exam});

  @override
  _TestQuestionPageState createState() => _TestQuestionPageState();
}

class _TestQuestionPageState extends State<TestQuestionPage> {
  int _currentQuestionNumber = 1;
  int _timerSeconds = 30;
  bool _isTimerRunning = true; // set to false to stop timer
  String? _selectedAnswer;
  List<Map<String, Object>> _questions = [
    {
      'question': 'Delhi is suituated on the bank of wich river?',
      'options': ['Yamuna', 'Pole Star', 'Pole', 'Kolkata'],
      'answer': 'Yamuna'
    },
    {
      'question': 'Name one crop of Assam that is very famous?',
      'options': ['Tea', 'Marina Beach', 'Tibet', 'Pole'],
      'answer': 'Tea'
    },
    {
      'question': 'What is the capital of India?',
      'options': ['New Delhi', 'Mumbai', 'Chennai', 'Kolkata'],
      'answer': 'New Delhi'
    },
    {
      'question': 'Who is the founder of Microsoft?',
      'options': ['Bill Gates', 'Steve Jobs', 'Larry Page', 'Mark Zuckerberg'],
      'answer': 'Bill Gates'
    },
  ];
  Map<String, Object> get _currentQuestion {
    return _questions[_currentQuestionNumber - 1];
  }

  String _buildQuestionNumbersString() {
    return List.generate(
      _questions.length,
      (index) => (index + 1).toString(),
    ).join(', ');
  }

  int?
      _selectedQuestionNumber; // Add this variable to keep track of the selected question number

  Widget TestQuestionPageQuestionNumber(
      String questionNumber, bool isLastQuestion) {
    bool isSelected = int.parse(questionNumber) ==
        _selectedQuestionNumber; // Check if the current question is selected

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentQuestionNumber = int.parse(questionNumber);
          _selectedAnswer = null;
          _selectedQuestionNumber =
              _currentQuestionNumber; // Store the selected question number
        });
      },
      child: Container(
        width: 30.w,
        height: 40.h,
        margin: EdgeInsets.symmetric(horizontal: 4.sp),
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          border: Border.all(color: Colors.grey),
          color: isSelected
              ? Colors.blue
              : Colors
                  .transparent, // Use the isSelected flag to determine the container color
        ),
        child: Center(
          child: Text(
            questionNumber,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerOption(String option, String optionNumber) {
    bool isSelected = _selectedAnswer == optionNumber;
    bool isCorrect = _currentQuestion['answer'] == option;
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 8.w),
            child: isSelected
                ? isCorrect
                    ? Icon(Icons.check, color: Colors.green, size: 20.sp)
                    : Icon(Icons.close, color: Colors.red, size: 20.sp)
                : Text(
                    optionNumber,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
          ),
          Expanded(
            child: Text(
              option,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLastQuestion = _currentQuestionNumber == _questions.length;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          widget.exam.name.toString(),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 16.w),
            child: Row(
              children: [
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                ),
                SizedBox(width: 4.w),
                Text('$_timerSeconds', style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Wrap(
              children: List.generate(
                _questions.length,
                (index) => TestQuestionPageQuestionNumber(
                    (index + 1).toString(), isLastQuestion),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  '$_currentQuestionNumber. ',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    _currentQuestion['question'] as String,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAnswer = (_currentQuestion
                              as Map<String, dynamic>)['options']?[i];
                        });
                      },
                      child: Center(
                        child: Material(
                          elevation: 2,
                          child: Container(
                            height: 60.h,
                            width: 350.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.sp),
                              color: _selectedAnswer ==
                                      (_currentQuestion as Map<String,
                                          dynamic>)['options']?[i]
                                  ? ((_currentQuestion as Map<String, dynamic>)[
                                              'answer'] ==
                                          (_currentQuestion as Map<String,
                                              dynamic>)['options']?[i]
                                      ? Colors.green.shade500
                                      : Colors.red.shade500)
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade200),
                                    child: Center(
                                      child: Text(
                                        String.fromCharCode(i + 65),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    (_currentQuestion as Map<String, dynamic>)[
                                            'options']?[i] ??
                                        '',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Spacer(),
          if (_currentQuestionNumber == _questions.length)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizResultPage()),
                );
              },
              child: Container(
                width: 327.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: Color(0xFF0058AC),
                ),
                child: Center(
                  child: Text(
                    'Finish',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            )
          else
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentQuestionNumber++;
                      _selectedAnswer = null;
                    });
                  },
                  child: Container(
                    width: 327.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: Color(0xFF0058AC),
                    ),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_currentQuestionNumber < _questions.length) {
                        _currentQuestionNumber++;
                        _selectedAnswer = null;
                      }
                    });
                  },
                  child: Container(
                    width: 327.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.sp),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
