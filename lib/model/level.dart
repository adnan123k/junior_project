import 'question.dart';

class Level {
  String title;
  int subjectId;
  bool passed;
  int id;
  List<Question> questions;
  Level(this.title, this.subjectId, this.passed, this.id, this.questions);
  factory Level.fromJson(Map<String, dynamic> data) {
    List<Question> temp = new List<Question>();

    for (int i = 0; i < data["questions"].length; i++) {
      temp.add(Question.fromJson(data["questions"][i]));
    }
    return Level(
        data["title"], data["subject_id"], data["passed"], data["id"], temp);
  }
}
