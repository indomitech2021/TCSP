import 'package:flutter/cupertino.dart';
import '../Models/ExamModel.dart';
import '../Models/WebinarModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppProvider with ChangeNotifier {
  List<Webinar> _webinars = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _currentPageIndex = 0;
  List<Exam> _exams = [];

  List<Webinar> get webinars => _webinars;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  get currentPageIndex => _currentPageIndex;
  get exams => _exams;

  void setCurrentPageIndex(int val){
    _currentPageIndex = val;
    notifyListeners();
  }



  Future<void> fetchWebinars() async {
    _isLoading = true;
    _errorMessage = '';

    final apiUrl = 'http://royadagency.com/api/admin/manageWebinar';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        print(decodedResponse.toString());
        if (decodedResponse['data'] != null) {
          _webinars = List<Webinar>.from(
              decodedResponse['data'].map((x) => Webinar.fromJson(x)));
          _isLoading = false;
        } else {
          _errorMessage = 'No webinars found.';
          _isLoading = false;
        }
      } else {
        _errorMessage = 'Failed to load webinars.';
        _isLoading = false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      _isLoading = false;
    }
    notifyListeners();
  }



  Future<List<Exam>> fetchExamData() async {
    final response = await http.get(Uri.parse('http://www.royadagency.com/api/user/exam_data'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Exam> exams = (jsonData['result'] as List).map((item) {
        List<Question> mcqs = (item['mcqs'] as List).map((mcq) => Question(
          id: mcq['id'],
          question: mcq['question'],
          answer1: mcq['answer1'],
          answer2: mcq['answer2'],
          answer3: mcq['answer3'],
          answer4: mcq['answer4'],
          correctAnswer: mcq['correctAnswer'],
        )).toList();

        return Exam(
          id: item['id'],
          name: item['name'],
          duration: item['duration'],
          passMark: item['pass_mark'],
          createdBy: item['created_by'],
          image: item['image'],
          createdAt: item['created_at'],
          updatedAt: item['updated_at'],
          mcqs: mcqs,
        );
      }).toList();

      _exams = exams;
      notifyListeners();
      return exams;
    } else {
      throw Exception('Failed to load exam data');
    }
  }




}
