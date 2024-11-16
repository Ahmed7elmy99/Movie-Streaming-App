import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteServices {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await init();
    return _database;
  }

  init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'movies.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
    return database;
  }

  onCreate(Database db, int version) async {
    // Removed single quotes around table and column names
    await db.execute(
        "CREATE TABLE favourites (id TEXT PRIMARY KEY, title TEXT, image TEXT)"
    );
  }

  Future<List<Map<String, dynamic>>> getData() async {
    Database? myDatabase = await database;
    List<Map<String, dynamic>> response = await myDatabase!.rawQuery("SELECT * FROM favourites");

    // Print the result to see what data is being fetched
    print(response);

    return response;
  }




  Future<void> insertData({
    required String id,
    required String title,
    required String image,
  }) async {
    Database? myDatabase = await database;
    // Removed single quotes around table and column names
    await myDatabase!.rawInsert(
        "INSERT INTO favourites (id, title, image) VALUES ('$id', '$title', '$image')"
    );
  }

  Future<int> deleteData({
    required String id,
  }) async {
    Database? myDatabase = await database;
    // Removed single quotes around table name
    int bookId = await myDatabase!.rawDelete("DELETE FROM favourites WHERE id = ?", [id]);
    return bookId;
  }
}
