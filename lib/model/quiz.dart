import 'package:junior_project/model/question.dart';

class Quiz extends Question {
  var points;
  var attemp;
  Quiz(
      {question,
      answer,
      choices,
      id,
      point,
      levelId,
      lessonId,
      passed = false,
      this.points,
      this.attemp})
      : super(
            question: question,
            answer: answer,
            choices: choices,
            id: id,
            point: point,
            levelId: levelId,
            lessonId: lessonId,
            passed: false);
  factory Quiz.fromJson(Map<String, dynamic> data) {
    List<String> temp = new List<String>();
    for (int i = 0; i < data["choice"].length; i++) {
      temp.add(data["choice"][i]);
    }
    return Quiz(
        id: data["id"],
        answer: data["answer"],
        point: data["point"],
        choices: temp,
        levelId: data["level_id"],
        lessonId: data["lesson_id"],
        question: data["question"],
        points: data["points"],
        attemp: data["attemp"]);
  }
}
