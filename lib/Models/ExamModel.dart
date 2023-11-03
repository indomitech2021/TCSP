class Exam {
  int id;
  String name;
  String duration;
  String passMark;
  String createdBy;
  String image;
  String createdAt;
  String updatedAt;
  List<Question> mcqs;

  Exam({
    required this.id,
    required this.name,
    required this.duration,
    required this.passMark,
    required this.createdBy,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.mcqs,
  });
}

class Question {
  int id;
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  String correctAnswer;

  Question({
    required this.id,
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
  });
}
