class Discussion {
  String userName;
  String body;
  int id;
  int user_id;
  int likes;
  bool liked;
  Discussion(
      this.userName, this.body, this.id, this.liked, this.user_id, this.likes);
  factory Discussion.fromJson(Map<String, dynamic> data) {
    return new Discussion(data["username"], data["body"], data["id"],
        data["liked"], data["user_id"], data["likes"]);
  }
}
