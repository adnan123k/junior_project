import 'package:flutter/foundation.dart';

import 'question.dart';

class checkBoxQuestion extends Question {
  final List<String> answer;
  final List<String> choices;
  checkBoxQuestion({this.answer, this.choices, question, type, seconds})
      : super(question: question, type: type, seconds: seconds);
  factory checkBoxQuestion.fromJson(Map<String, dynamic> data) {
    return new checkBoxQuestion(
        answer: data["answer"],
        choices: data["choices"],
        question: data["question"],
        type: data["type"],
        seconds: data["seconds"]);
  }
}
