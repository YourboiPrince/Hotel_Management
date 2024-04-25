class UserModel {
  final String? uid;
  final String? email;
  final String? displayName;

  UserModel({this.uid, this.email, this.displayName});

  // Convert UserModel to a Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
    };
  }
}
