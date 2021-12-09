class Discussion {
  String userName;
  String body;
  int id;
  Discussion(this.userName, this.body, this.id);
  factory Discussion.fromJson(Map<String, dynamic> data) {
    return new Discussion(data["userName"], data["body"], data["id"]);
  }
}
