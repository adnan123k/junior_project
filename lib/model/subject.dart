import 'lesson.dart';

class Subject extends Lesson {
  List<Lesson> lessons;
  Subject(int id, String title, this.lessons) : super(id, title);
  factory Subject.fromJson(Map<String, dynamic> data) {
    List<Lesson> temp = new List<Lesson>();
    for (int i = 0; i < data["lessons"].length; i++) {
      temp.add(Lesson.fromJson(data["lessons"][i]));
    }
    return Subject(data["id"], data["title"], temp);
  }
}
