
import 'member.dart';

class ChatGroup {
  final int? id;
  final String name;
  final String lastMessage;
  final String time;
  final String image;
  final int timestamp;
 /* List<Member> members; // List of members
  int numberOfMembers; // Number of members*/


  ChatGroup({
    this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.image,
    required this.timestamp,
    // required this.members,
    // required this.numberOfMembers
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastMessage': lastMessage,
      'time': time,
      'image': image,
      'timestamp': timestamp,
      // 'numberOfMembers': numberOfMembers,
    };
  }

  factory ChatGroup.fromMap(Map<String, dynamic> map) {
    return ChatGroup(
      id: map['id'],
      name: map['name'],
      lastMessage: map['lastMessage'],
      time: map['time'],
      image: map['image'],
      timestamp: map['timestamp'],
      // members: [], // Initialize with empty list
      // numberOfMembers: map['numberOfMembers'],
    );
  }

  @override
  String toString() {
    return "id : ${id} ,name : ${name} ,time : ${time} ,image : ${image} , timestamp : ${timestamp}";
  }
}
