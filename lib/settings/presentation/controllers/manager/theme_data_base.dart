import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ThemeDatabase {
  static final ThemeDatabase _instance = ThemeDatabase._internal();
  factory ThemeDatabase() => _instance;

  static Database? _database;

  ThemeDatabase._internal();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'theme.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE theme(id INTEGER PRIMARY KEY, themeMode TEXT)',
        );
      },
    );
  }

  Future<void> insertTheme(String themeMode) async {
    final db = await database;
    await db?.insert(
      'theme',
      {'id': 1, 'themeMode': themeMode},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getTheme() async {
    final db = await database;
    final result = await db?.query('theme');
    if (result?.isNotEmpty ?? false) {
      return result?.first['themeMode'] as String?;
    }
    return null; // Default theme if not found
  }
}
