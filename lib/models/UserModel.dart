class UserModel {
  late final String email;
  late final String password;
  late String uid;

  UserModel({
    this.uid = "",
    required this.email,
    required this.password,
  });

  UserModel.b({
    required this.uid,
    required this.email,
    this.password = "",
  });

  set setUid(value) => uid = value;

  Map<String, dynamic> toJson() => {
        'uid:': uid,
        'email': email,
        'password': password,
      };
}
