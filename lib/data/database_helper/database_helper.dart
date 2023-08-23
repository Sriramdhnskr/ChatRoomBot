import 'package:chatroom_chatbot/data/model/member.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/chatgroup.dart';
import '../model/user.dart';
import '../model/user_profile.dart';

List<UserProfile> sampleProfiles = [
  UserProfile(
    image: "https://randomuser.me/api/portraits/men/1.jpg",
    name: "John Doe",
  ),
  UserProfile(
    image: "https://randomuser.me/api/portraits/men/2.jpg",
    name: "Jane Smith",
  ),
  UserProfile(
    image: "https://randomuser.me/api/portraits/men/3.jpg",
    name: "Michael Johnson",
  ),
  UserProfile(
    image: "https://randomuser.me/api/portraits/men/4.jpg",
    name: "Sandy",
  ),
  UserProfile(
    image: "https://randomuser.me/api/portraits/men/5.jpg",
    name: "Joseph",
  ),
  UserProfile(
    image: "https://randomuser.me/api/portraits/men/6.jpg",
    name: "Arya",
  ),
  UserProfile(
    image: "https://randomuser.me/api/portraits/men/7.jpg",
    name: "Michael Tyson",
  ),
];

List<User> sampleUsers = [
  User(
    olmid: "A157L8S8",
    image: "https://randomuser.me/api/portraits/men/8.jpg",
    username: "Sriram D",
  ),
  User(
    olmid: "A157L8S7",
    image: "https://randomuser.me/api/portraits/men/9.jpg",
    username: "Saransh Sharma",
  ),
  User(
    olmid: "A157L7S7",
    image: "https://randomuser.me/api/portraits/men/10.jpg",
    username: "Abhay",
  ),
  User(
    olmid: "A157L7S6",
    image: "https://randomuser.me/api/portraits/men/11.jpg",
    username: "Pranawesh Kumar",
  ),

];



var _initialChatGroups = [
  ChatGroup(
      // id: 1,
      name: 'Transmision Team',
      lastMessage: 'Hello there!',
      time: '10:30 AM',
      image: 'https://picsum.photos/id/100/200/200',
      timestamp:
          DateTime.now().subtract(Duration(hours: 1)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 2,
      name: 'Operations Team',
      lastMessage: 'Just finished the project!',
      time: '9:40 AM',
      image: 'https://picsum.photos/id/101/200/200',
      timestamp:
          DateTime.now().subtract(Duration(hours: 2)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 3,
      name: 'Optical Power Team',
      lastMessage: 'Are we meeting tomorrow?',
      time: '7:40 AM',
      image: 'https://picsum.photos/id/102/200/200',
      timestamp:
          DateTime.now().subtract(Duration(hours: 3)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 4,
      name: 'ISP/MPLS Team',
      lastMessage: 'Let\'s catch up this weekend.',
      time: 'Yesterday',
      image: 'https://picsum.photos/id/103/200/200',
      timestamp:
          DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 5,
      name: 'Niiva Team',
      lastMessage:
          'Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!Flutter is awesome!',
      time: '2 days ago',
      image: 'https://picsum.photos/id/104/200/200',
      timestamp:
          DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 6,
      name: 'Family Chat',
      lastMessage: 'Planning for the weekend!',
      time: '3 days ago',
      image: 'https://picsum.photos/id/104/200/200',
      timestamp:
          DateTime.now().subtract(Duration(days: 3)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 7,
      name: 'Friends Hangout',
      lastMessage: 'Movie night this Friday?',
      time: '3 days ago',
      image: 'https://picsum.photos/id/106/200/200',
      timestamp:
          DateTime.now().subtract(Duration(days: 3)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 8,
      name: 'Work Team',
      lastMessage: 'Review meeting at 3 PM.',
      time: '4 days ago',
      image: 'https://picsum.photos/id/107/200/200',
      timestamp:
          DateTime.now().subtract(Duration(days: 4)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 9,
      name: 'Fitness Buddies',
      lastMessage: 'Are we going for a run?',
      time: '5 days ago',
      image: 'https://picsum.photos/id/108/200/200',
      timestamp:
          DateTime.now().subtract(Duration(days: 5)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 10,
      name: 'Travel Enthusiasts',
      lastMessage: 'Destination ideas for summer?',
      time: '1 week ago',
      image: 'https://picsum.photos/id/109/200/200',
      timestamp:
          DateTime.now().subtract(Duration(days: 7)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 11,
      name: 'Book Club',
      lastMessage: 'Discussing next month\'s book.',
      time: '2 weeks ago',
      image: 'https://picsum.photos/id/110/200/200',
      timestamp:
          DateTime.now().subtract(Duration(days: 14)).millisecondsSinceEpoch),
  ChatGroup(
      // id: 12,
      name: 'Study Group',
      lastMessage: 'Let\'s prepare for the exam!',
      time: '3 weeks ago',
      image: 'https://picsum.photos/id/111/200/200',
      timestamp:
          DateTime.now().subtract(Duration(days: 21)).millisecondsSinceEpoch),
];


var _initialMemberDetails = [
  Member(name: "John Doe", imageUrl: "https://randomuser.me/api/portraits/men/1.jpg"),
  Member(name: "Jane Smith", imageUrl: "https://randomuser.me/api/portraits/men/2.jpg"),
  Member( name: "Michael Johnson", imageUrl: "https://randomuser.me/api/portraits/men/3.jpg"),
  Member( name: "Sandy", imageUrl: "https://randomuser.me/api/portraits/men/4.jpg"),
  Member( name: "Joseph", imageUrl: "https://randomuser.me/api/portraits/men/5.jpg"),
  Member( name: "Arya", imageUrl: "https://randomuser.me/api/portraits/men/6.jpg"),
  Member( name: "Michael Tyson", imageUrl: "https://randomuser.me/api/portraits/men/7.jpg"),
];

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_groups.db');
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE chat_groups(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            lastMessage TEXT,
            time TEXT,
            image TEXT,
            timestamp INTEGER
          )
        ''');

        db.execute('''
    CREATE TABLE members(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      chatGroupId INTEGER,
      name TEXT,
      image TEXT
    )
  ''');

        db.execute('''
    CREATE TABLE userprofiles(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      image TEXT
    )
  ''');

        db.execute('''
    CREATE TABLE user_data(
      olmid TEXT PRIMARY KEY,
      userName TEXT,
      userImage TEXT
    )
  ''');
      },
    );

    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM chat_groups'));
    if (count == 0) {
// Insert initial chat groups into the database
      for (final chatGroup in _initialChatGroups) {
        final chatGroupId = await db.insert('chat_groups', chatGroup.toMap());

        print("group id DB $chatGroupId");

        for (final member in _initialMemberDetails) {
          await db.insert(
            'members',
            {
              'chatGroupId': chatGroupId,
              'name': member.name,
              'image': member.imageUrl,
            },
          );
        }
      }


    for (final member in sampleProfiles) {
        await db.insert('userprofiles', member.toMap());
      }

      for (final user in sampleUsers) {
        await db.insert('user_data', user.toMap());
      }
    }

    return db;
  }

  Future<void> insertChatGroup(ChatGroup chatGroup) async {
    final db = await database;
    await db.insert(
      'chat_groups',
      chatGroup.toMap(),
    );
  }

  Future<List<ChatGroup>> getChatGroups() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'chat_groups',
      orderBy: 'timestamp DESC', // Order by timestamp in descending order
    );

    return List.generate(
      maps.length,
      (i) {
        print(ChatGroup.fromMap(maps[i]));
        return ChatGroup.fromMap(maps[i]);
      },
    );
  }

  Future<List<Member>> getChatMembers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'members',
    );

    return List.generate(
      maps.length,
          (i) {
        print(Member.fromMap(maps[i]));
        return Member.fromMap(maps[i]);
      },
    );
  }


  Future<List<UserProfile>> getUserProfiles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'userprofiles', // Order by timestamp in descending order
    );

    return List.generate(
      maps.length,
          (i) {
        print(UserProfile.fromMap(maps[i]));
        return UserProfile.fromMap(maps[i]);
      },
    );
  }

  Future<void> updateChatGroup(ChatGroup chatGroup) async {
    final db = await database;
    await db.update(
      'chat_groups',
      chatGroup.toMap(),
      where: 'id = ?',
      whereArgs: [chatGroup.id],
    );
  }

  Future<ChatGroup?> fetchChatGroupById(int groupId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'chat_groups',
      where: 'id = ?',
      whereArgs: [groupId],
    );

    if (maps.isNotEmpty) {
      return ChatGroup.fromMap(maps.first);
    }
    return null; // Group not found
  }

  Future<List<Member>> fetchMembersForGroup(int groupId) async {

    print("group Id DB ${groupId}");

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'members',
      where: 'chatGroupId = ?',
      whereArgs: [groupId],
    );

    print("Maps : ${maps}");
    return List.generate(maps.length, (index) {
      return Member(
        name: maps[index]['name'],
        imageUrl: maps[index]['image'],
      );
    });
  }

  Future<void> addMemberToGroup(ChatGroup group, Member member) async {
    final db = await database;

    await db.insert(
      'members',
      {
        'chatGroupId': group.id,
        'name': member.name,
        'image': member.imageUrl,
      },
    );
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('user_data', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<User> getUser(String olmid) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user_data',
      where: 'olmid = ?',
      whereArgs: [olmid],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      throw Exception('User not found');
    }
  }
}

