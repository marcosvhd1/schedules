import 'package:schedule/src/models/schedule.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'schedules.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute(
      "CREATE TABLE schedules("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title TEXT, description TEXT, isCompleted INTEGER, "
      "date TEXT, startTime TEXT, endTime TEXT, "
      "color INTEGER, remind INTEGER, repeat TEXT)",
    );
  }

  static Future<int> createSchedule(Schedule schedule) async {
    final db = await DBHelper.db();
    final id = await db.insert('schedules', schedule.toJSON());
    return id;
  }

  static Future<void> update(int id) async {
    // final db = await DBHelper.db();

    // await db.delete('schedules', where: "id = ?", whereArgs: [id]);
  }

  static Future<void> updateIsCompleted(int id, int isCompleted) async {
    final db = await DBHelper.db();

    await db.update('schedules', {'isCompleted': isCompleted}, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getSchedules() async {
    final db = await DBHelper.db();
    return db.query('schedules', orderBy: "id");
  }

  static Future<void> delete(int id) async {
    final db = await DBHelper.db();

    await db.delete('schedules', where: "id = ?", whereArgs: [id]);
  }
}