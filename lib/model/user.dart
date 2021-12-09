class User {
  String userName;
  String token;
  String type;
  int points;
  User(this.userName, this.token, this.type, this.points);
  factory User.fromJson(Map<String, dynamic> data) {
    return new User(
        data["username"], data["token"], data["type"], data["points"]);
  }

  factory User.fromJson2(Map<String, dynamic> data) {
    return new User(data["username"], "", "", data["points"]);
  }
}
