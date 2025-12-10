class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? phone;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );
}
