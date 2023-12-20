class UserModel {
  UserModel(
      {this.userName,
      this.emailAddress,
      this.uID,
      this.fvTopics,
      this.savedNews});

  UserModel.fromJson(dynamic json) {
    userName = json['userName'];
    emailAddress = json['emailAddress'];
    uID = json['uID'];
    fvTopics = json['fvTopics'] != null ? json['fvTopics'].cast<String>() : [];
    savedNews =
        json['savedNews'] != null ? json['savedNews'].cast<String>() : [];
  }
  String? userName;
  String? emailAddress;
  String? uID;
  List<String>? fvTopics;
  List<String>? savedNews;
  UserModel copyWith({
    String? userName,
    String? emailAddress,
    String? uID,
    List<String>? fvTopics,
    List<String>? savedNews,
  }) =>
      UserModel(
          userName: userName ?? this.userName,
          emailAddress: emailAddress ?? this.emailAddress,
          uID: uID ?? this.uID,
          fvTopics: fvTopics ?? this.fvTopics,
          savedNews: savedNews ?? this.savedNews);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['emailAddress'] = emailAddress;
    map['uID'] = uID;
    map['fvTopics'] = fvTopics;
    map['savedNews'] = savedNews;
    return map;
  }
}
