class User {
  int id;
  String userName;
  String token;
  String type;
  String motherName;
  String fatherName;
  int points;

  User(this.id, this.userName, this.token, this.type, this.points,
      this.motherName, this.fatherName);
  factory User.fromJson(Map<String, dynamic> data) {
    return new User(
        data["data"]["id"],
        data["data"]["username"],
        "Bearer " + data["token"],
        data["data"]["role"],
        data["data"]["points"],
        data["data"]["mother_name"],
        data["data"]["father_name"]);
  }

  factory User.fromJson2(Map<String, dynamic> data) {
    return new User(0, data["username"], "", "", data["points"], "", "");
  }
  factory User.fromJson3(Map<String, dynamic> data) {
    return new User(data["id"], data["username"], "", data["role"],
        data["points"], data["mother_name"], data["father_name"]);
  }
}
