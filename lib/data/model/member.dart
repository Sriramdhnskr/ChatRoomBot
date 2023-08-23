class Member {
  final int? id;
  final int? chatGroupId;
  final String name;
  final String imageUrl;

  Member( {this.id,this.chatGroupId,required this.name, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': name,
      'image': imageUrl,
      'chatGroupId' : chatGroupId
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id : map['id'],
      name: map['name'],
      imageUrl: map['image'],
      chatGroupId: map['chatGroupId'],
    );
  }

  @override
  String toString() {
    return "id : ${id},chatgroupId : ${chatGroupId} , name: ${name} and ${imageUrl}";
  }
}