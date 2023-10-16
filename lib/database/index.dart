import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PV {
  final int id;
  final String title;
  final String description;
  final String image;
  PV({
    required this.id,
    required this.title,
    required this.description,
    required this.image
  });

  PV.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        description = res["description"],
        image=res["image"];
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image':image
    };
  }
}

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'populardb.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE populartv(id INTEGER PRIMARY KEY , title TEXT, description TEXT,image TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertUser(List<PV> pvs) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var pv in pvs){
      result = await db.insert('populartv', pv.toMap());
    }
    return result;
  }

  Future<List<PV>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('populartv');
    return queryResult.map((e) => PV.fromMap(e)).toList();
  }
   Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(
      'populartv',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
