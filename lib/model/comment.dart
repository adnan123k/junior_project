class Comment {
  String userName;
  String body;
  int id;
  int user_id;
  int likes;
  bool liked;
  Comment(
      this.userName, this.body, this.id, this.liked, this.user_id, this.likes);
  factory Comment.fromJson(Map<String, dynamic> data) {
    return new Comment(data["username"], data["body"], data["id"],
        data["liked"], data["user_id"], data["likes"]);
  }
}
