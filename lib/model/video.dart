class Video {
  String title;
  String description;
  String url;
  int id;
  String fullName;
  int lessonId;
  int teacherId;
  Video(this.title, this.description, this.url, this.id, this.fullName,
      this.lessonId, this.teacherId);
  factory Video.fromJson(Map<String, dynamic> data) {
    return Video(data["title"], data["description"], data["url"], data["id"],
        data["full_name"], data["lesson_id"], data["teacher_id"]);
  }
}
