import 'question.dart';

class inputQuestion extends Question {
  final String answer;

  inputQuestion({this.answer, question, type, seconds})
      : super(question: question, type: type, seconds: seconds);
}
