class UserProfile {
  final int? id;
  final String name;
  final String image;

  UserProfile( {this.id,required this.name, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
  }
}