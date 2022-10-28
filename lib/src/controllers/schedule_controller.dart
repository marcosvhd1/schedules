import 'package:flutter/cupertino.dart';
import 'package:schedule/data/database.dart';
import 'package:schedule/src/models/schedule.dart';

class ScheduleController extends ChangeNotifier {
  final List<Schedule> _schedules = [];

  List<Schedule> get schedules => [..._schedules];

  Future<void> getSchedules() async {
    _schedules.clear();
    final data = await DBHelper.getSchedules();

    for (var json in data) {
      _schedules.add(Schedule(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'],
        date: json['date'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        color: json['color'],
        remind: json['remind'],
        repeat: json['repeat'],
      ));
    }

    notifyListeners();
  }

  Future<void> setSchedule(Schedule schedule) async {
    await DBHelper.setSchedule(schedule);

    getSchedules();
  }

  Future<void> finishSchedule(int id) async {
    await DBHelper.finishSchedule(id);

    getSchedules();
  }

  Future<void> deleteSchedule(int id) async {
    await DBHelper.deleteSchedule(id);

    getSchedules();
  }
}