import 'package:schedule/src/models/schedule.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<sql.Database> _db() async {
    return sql.openDatabase(
      'schedules.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await _createSchedulesTable(database);
      },
    );
  }

  static Future<void> _createSchedulesTable(sql.Database database) async {
    await database.execute(
      "CREATE TABLE schedules("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title TEXT, description TEXT, isCompleted INTEGER, "
      "date TEXT, startTime TEXT, endTime TEXT, "
      "color INTEGER, remind INTEGER, repeat TEXT)",
    );
  }

  static Future<List<Map<String, dynamic>>> getSchedules() async {
    final db = await DBHelper._db();
    return db.query('schedules', orderBy: "id");
  }

  static Future<int> setSchedule(Schedule schedule) async {
    final db = await DBHelper._db();
    final data = {
      'title': schedule.title,
      'description': schedule.description,
      'isCompleted': schedule.isCompleted, 
      'date': schedule.date,
      'startTime': schedule.startTime, 
      'endTime': schedule.endTime, 
      'color': schedule.color, 
      'remind': schedule.remind, 
      'repeat': schedule.repeat, 
    };

    final id = await db.insert('schedules', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<void> finishSchedule(int id) async {
    final db = await DBHelper._db();

    await db.update('schedules', {'isCompleted': 1}, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteSchedule(int id) async {
    final db = await DBHelper._db();

    await db.delete('schedules', where: "id = ?", whereArgs: [id]);
  }
}