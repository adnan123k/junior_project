class Comment {
  String userName;
  String body;
  int id;
  Comment(this.userName, this.body, this.id);
  factory Comment.fromJson(Map<String, dynamic> data) {
    return new Comment(data["userName"], data["body"], data["id"]);
  }
}
