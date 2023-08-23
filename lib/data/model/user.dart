
class User {
  final String olmid;
  final String username;
  final String image;

  User({required this.olmid, required this.username, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'olmid': olmid,
      'userName': username,
      'userImage': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      olmid: map['olmid'],
      username: map['userName'],
      image: map['userImage'],
    );
  }
}