class Question {
  final String question;

  final String answer;
  final List<String> choices;
  int id;
  int point;
  int levelId;
  int lessonId;
  bool passed;
  Question(
      {this.question,
      this.answer,
      this.choices,
      this.id,
      this.point,
      this.levelId,
      this.lessonId,
      this.passed = false});
  factory Question.fromJson(Map<String, dynamic> data) {
    List<String> temp = new List<String>();
    for (int i = 0; i < data["choice"].length; i++) {
      temp.add(data["choice"][i]);
    }
    return Question(
        id: data["id"],
        answer: data["answer"],
        point: data["point"],
        choices: temp,
        levelId: data["level_id"],
        lessonId: data["lesson_id"],
        question: data["question"]);
  }
  Map<String, dynamic> toJson() => {
        'question_id': id,
        'id': id,
        'answer': answer,
        'choice': choices,
        'point': point,
        'level_id': levelId,
        'question': question,
        'lesson_id': lessonId,
        'passed': passed
      };
}
