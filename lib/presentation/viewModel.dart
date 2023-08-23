import 'package:chatroom_chatbot/data/model/member.dart';
import 'package:chatroom_chatbot/data/model/user_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/database_helper/database_helper.dart';
import '../data/model/chatgroup.dart';
import '../data/model/user.dart';

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);

  if (dateTime.isAfter(today)) {
    return DateFormat.jm().format(dateTime); // Time format
  } else if (dateTime.isAtSameMomentAs(today)) {
    return DateFormat.jm().format(dateTime); // Time format for today
  } else if (dateTime.isAtSameMomentAs(yesterday)) {
    return 'Yesterday'; // Yesterday
  } else {
    return DateFormat('dd/MM/yyyy').format(dateTime); // Date format
  }
}

final chatGroupsProvider = ChangeNotifierProvider<ChatGroupsViewModel>((ref) {
  return ChatGroupsViewModel();
});

// var _initialChatGroups = [
//   ChatGroup(
//     id:1,
//       name: 'Transmision Team',
//       lastMessage: 'Hello there!',
//       time: '10:30 AM',
//       image: 'https://picsum.photos/id/100/200/200'),
//   ChatGroup(
//     id:2,
//     name: 'Operations Team',
//     lastMessage: 'Just finished the project!',
//     time: '9:40 AM',
//     image: 'https://picsum.photos/id/101/200/200',
//   ),
//   ChatGroup(
//     id:3,
//     name: 'Optical Power Team',
//     lastMessage: 'Are we meeting tomorrow?',
//     time: '7:40 AM',
//     image: 'https://picsum.photos/id/102/200/200',
//   ),
//   ChatGroup(
//     id:4,
//     name: 'ISP/MPLS Team',
//     lastMessage: 'Let\'s catch up this weekend.',
//     time: 'Yesterday',
//     image: 'https://picsum.photos/id/103/200/200',
//   ),
//   ChatGroup(
//       id:5,
//       name: 'Niiva Team',
//       lastMessage:
//           'Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!',
//       time: '2 days ago',
//       image: 'https://picsum.photos/id/104/200/200'),
//   ChatGroup(
//     id:6,
//     name: 'Family Chat',
//     lastMessage: 'Planning for the weekend!',
//     time: '3 days ago',
//     image: 'https://picsum.photos/id/105/200/200',
//   ),
//   ChatGroup(
//     id:7,
//     name: 'Friends Hangout',
//     lastMessage: 'Movie night this Friday?',
//     time: '3 days ago',
//     image: 'https://picsum.photos/id/106/200/200',
//   ),
//   ChatGroup(
//     id:8,
//     name: 'Work Team',
//     lastMessage: 'Review meeting at 3 PM.',
//     time: '4 days ago',
//     image: 'https://picsum.photos/id/107/200/200',
//   ),
//   ChatGroup(
//     id:9,
//     name: 'Fitness Buddies',
//     lastMessage: 'Are we going for a run?',
//     time: '5 days ago',
//     image: 'https://picsum.photos/id/108/200/200',
//   ),
//   ChatGroup(
//     id:10,
//     name: 'Travel Enthusiasts',
//     lastMessage: 'Destination ideas for summer?',
//     time: '1 week ago',
//     image: 'https://picsum.photos/id/109/200/200',
//   ),
//   ChatGroup(
//     id:11,
//     name: 'Book Club',
//     lastMessage: 'Discussing next month\'s book.',
//     time: '2 weeks ago',
//     image: 'https://picsum.photos/id/110/200/200',
//   ),
//   ChatGroup(
//     id:12,
//     name: 'Study Group',
//     lastMessage: 'Let\'s prepare for the exam!',
//     time: '3 weeks ago',
//     image: 'https://picsum.photos/id/111/200/200',
//   ),
// ];

class ChatGroupsViewModel extends ChangeNotifier {
  List<ChatGroup> _chatGroups = [];

  List<ChatGroup> get chatGroups => _chatGroups;

  List<Member> _chatmembers = [];

  List<Member> get chatmembers => _chatmembers;

  List<Member> _members = [];

  List<Member> get members => _members;

  List<UserProfile> _userProfiles = [];

  List<UserProfile> get userProfiles => _userProfiles;

  ChatGroup? _selectedChatGroup;

  ChatGroup get selectedChatGroup => _selectedChatGroup!;

  /*ChatGroupsViewModel() {
    if (_chatGroups.isEmpty) {
      fetchChatGroups();
    }
  }*/

  Future<void> fetchChatGroups() async {
    _chatGroups = await DatabaseHelper.instance.getChatGroups();
    // fetchMembers();
    notifyListeners();
  /*  _chatGroups.forEach((element) {
      print(element.toString());
    });*/
  }

  Future<void> fetchMembers() async {
    _chatmembers = await DatabaseHelper.instance.getChatMembers();
    notifyListeners();
    // notifyListeners();
    /*  _chatGroups.forEach((element) {
      print(element.toString());
    });*/
  }

  Future<void> fetchUserProfiles() async {
    _userProfiles = await DatabaseHelper.instance.getUserProfiles();
    notifyListeners();
    /*  _chatGroups.forEach((element) {
      print(element.toString());
    });*/
  }

  Future<void> updateChatGroup(ChatGroup chatGroup) async {
    print("updated chatgroup: ${chatGroup.toString()}");
    await DatabaseHelper.instance.updateChatGroup(chatGroup);
    await fetchChatGroup(chatGroup.id!);
    await fetchChatGroups();
  }

  Future<void> addChatGroup(ChatGroup chatGroup) async {
    await DatabaseHelper.instance.insertChatGroup(chatGroup);
    await fetchChatGroups();
  }

  Future<void> addMember(ChatGroup chatGroup,Member member) async {
    await DatabaseHelper.instance.addMemberToGroup(chatGroup, member);
    if(chatGroup.id!=null)
      {
        await fetchChatMembers(chatGroup.id!);
      }
  }

  Future<void> fetchChatGroup(int groupId) async {
    _selectedChatGroup =  (await DatabaseHelper.instance.fetchChatGroupById(groupId))!;
    notifyListeners();
  }

  Future<void> fetchChatMembers(int groupId) async {
    _members =  await DatabaseHelper.instance.fetchMembersForGroup(groupId);
    notifyListeners();
  }

  Future<void> addUser(String olmid, String username, String image) async {
    final user = User(olmid: olmid, username: username, image: image);
    await DatabaseHelper.instance.insertUser(user);
  }

  Future<User> getUser(String olmid) async {
    return DatabaseHelper.instance.getUser(olmid);
  }

}

/*void fetchChatGroups() {
    // Simulate fetching chat groups from an API or database
    _chatGroups =[
      ChatGroup(
          name: 'Transmision Team',
          lastMessage: 'Hello there!',
          time:'10:30 AM',
          image: 'https://picsum.photos/id/100/200/200'),
      ChatGroup(
        name: 'Operations Team',
        lastMessage: 'Just finished the project!',
        time:'9:40 AM',
        image:'https://picsum.photos/id/101/200/200',
      ),
      ChatGroup(
        name: 'Optical Power Team',
        lastMessage: 'Are we meeting tomorrow?',
        time:'7:40 AM',
        image:'https://picsum.photos/id/102/200/200',
      ),
      ChatGroup(
        name:  'ISP/MPLS Team',
        lastMessage: 'Let\'s catch up this weekend.',
        time:'Yesterday',
        image:'https://picsum.photos/id/103/200/200',
      ),
      ChatGroup(
          name:   'Niiva Team',
          lastMessage:  'Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!',
          time:'2 days ago',
          image:'https://picsum.photos/id/104/200/200'),
      ChatGroup(
        name:  'Family Chat',
        lastMessage: 'Planning for the weekend!',
        time:'3 days ago',
        image:'https://picsum.photos/id/105/200/200',
      ),
      ChatGroup(
        name: 'Friends Hangout',
        lastMessage: 'Movie night this Friday?',
        time:'3 days ago',
        image:'https://picsum.photos/id/106/200/200',
      ),
      ChatGroup(
        name:  'Work Team',
        lastMessage:  'Review meeting at 3 PM.',
        time:'4 days ago',
        image:'https://picsum.photos/id/107/200/200',
      ),
      ChatGroup(
        name:  'Fitness Buddies',
        lastMessage:  'Are we going for a run?',
        time:'5 days ago',
        image:'https://picsum.photos/id/108/200/200',
      ),
      ChatGroup(
        name:  'Travel Enthusiasts',
        lastMessage: 'Destination ideas for summer?',
        time:'1 week ago',
        image:'https://picsum.photos/id/109/200/200',
      ),
      ChatGroup(
        name:  'Book Club',
        lastMessage: 'Discussing next month\'s book.',
        time:'2 weeks ago',
        image:'https://picsum.photos/id/110/200/200',
      ),
      ChatGroup(
        name: 'Study Group',
        lastMessage: 'Let\'s prepare for the exam!',
        time:'3 weeks ago',
        image:'https://picsum.photos/id/111/200/200',
      ),

      // Add more chat groups here
    ];
    notifyListeners();
  }

  void updateChatGroup(ChatGroup updatedChatGroup) {

   */ /* final newGroup = ChatGroup(
      time: chatGroup.time,
      name: groupName,
      lastMessage: chatGroup.lastMessage,
      image: groupImage, // Set the group image
    );*/ /*

    final index = _chatGroups.indexWhere((group) => group.name == updatedChatGroup.name);
    if (index != -1) {
      _chatGroups[index] = updatedChatGroup;
      notifyListeners();
    }
  }

  void addChatGroup(String groupName,String groupImage) {

    var dateTime = DateTime
        .now();

    final newGroup = ChatGroup(
      time: formatDateTime(dateTime),
      name: groupName,
      lastMessage: 'No messages yet',
      image: groupImage, // Set the group image
    );

    _chatGroups.insert(0, newGroup); // Insert at the beginning
    notifyListeners();
  }*/
