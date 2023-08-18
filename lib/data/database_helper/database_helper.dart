
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/chatgroup.dart';

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
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE chat_groups(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            lastMessage TEXT,
            time TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertChatGroup(ChatGroup chatGroup) async {
    final db = await database;
    await db.insert(
      'chat_groups',
      chatGroup.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChatGroup>> getChatGroups() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('chat_groups');
    return List.generate(
      maps.length,
          (i) {
        print(ChatGroup.fromMap(maps[i]));
        return ChatGroup.fromMap(maps[i]);
      },
    );
  }

  Future<void> updateChatGroup(ChatGroup chatGroup) async {
    final db = await database;
    await db.update(
      'chat_groups',
      chatGroup.toMap(),
      where: 'id = ?',
      // whereArgs: [chatGroup.id],
    );
  }
}