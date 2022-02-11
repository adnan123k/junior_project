class Lesson {
  int id;
  String title;

  Lesson(this.id, this.title);
  factory Lesson.fromJson(Map<String, dynamic> data) {
    return Lesson(data["id"], data["title"]);
  }
}
