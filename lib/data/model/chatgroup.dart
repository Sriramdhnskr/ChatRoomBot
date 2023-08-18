
class ChatGroup {
  final int? id;
  final String name;
  final String lastMessage;
  final String time;
  final String image;

  ChatGroup({
    this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastMessage': lastMessage,
      'time': time,
      'image': image,
    };
  }

  factory ChatGroup.fromMap(Map<String, dynamic> map) {
    return ChatGroup(
      id: map['id'],
      name: map['name'],
      lastMessage: map['lastMessage'],
      time: map['time'],
      image: map['image'],
    );
  }
}
