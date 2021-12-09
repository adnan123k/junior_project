import 'question.dart';

class radioQuestion extends Question {
  final String answer;
  final List<String> choices;
  radioQuestion({this.answer, this.choices, question, type, seconds})
      : super(question: question, type: type, seconds: seconds);
}
