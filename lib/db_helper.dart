import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TranscriptionItem {
  final int? id;
  final String text;
  final String date;
  final String audioPath;
  final String language;

  TranscriptionItem({
    this.id,
    required this.text,
    required this.date,
    required this.audioPath,
    required this.language,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'date': date,
      'audioPath': audioPath,
      'language': language,
    };
  }

  factory TranscriptionItem.fromMap(Map<String, dynamic> map) {
    return TranscriptionItem(
      id: map['id'],
      text: map['text'],
      date: map['date'],
      audioPath: map['audioPath'],
      language: map['language'],
    );
  }
}

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'transcriptions.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            text TEXT,
            date TEXT,
            audioPath TEXT,
            language TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insert(TranscriptionItem item) async {
    final db = await database;
    return await db.insert('history', item.toMap());
  }

  static Future<List<TranscriptionItem>> getHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('history', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => TranscriptionItem.fromMap(maps[i]));
  }

  static Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('history', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> clearAll() async {
    final db = await database;
    return await db.delete('history');
  }
}