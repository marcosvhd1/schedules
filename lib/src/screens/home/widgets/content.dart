import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/data/database.dart';
import 'package:schedule/services/notifications_services.dart';
import 'package:schedule/src/models/schedule.dart';
import 'package:schedule/src/screens/home/widgets/header.dart';
import 'package:schedule/src/screens/home/widgets/schedule_tile.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<Map<String, dynamic>> schedules = [];

  DateTime selectedDate = DateTime.now();

  NotifyHelper notifyHelper = NotifyHelper();

  @override
  void initState() {
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    loadSchedules();
    super.initState();
  }

  void loadSchedules() async {
    final data = await DBHelper.getSchedules();
    setState(() => schedules = data);
  }

  @override
  Widget build(BuildContext context) {
    final orient = MediaQuery.of(context).orientation;
    final vertical = orient == Orientation.portrait;
    return Column(
      children: [
        Header(run: loadSchedules),
        Padding(
          padding: EdgeInsets.symmetric(vertical: vertical ? 10.h : 15.h, horizontal: 5.w),
          child: DatePicker(
            locale: 'pt',
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: primaryClr,
            selectedTextColor: white,
            monthTextStyle: monthStyle,
            dateTextStyle: dateStyle,
            dayTextStyle: dayStyle,
            onDateChange: (date) {
              setState(() => selectedDate = date);
              loadSchedules();
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: vertical ? 10.h : 30.h),
            itemCount: schedules.length,
            itemBuilder: (c, i) {
              String day = schedules[i]['date'].toString().split('/')[0];
              String month = schedules[i]['date'].toString().split('/')[1];
              String year = schedules[i]['date'].toString().split('/')[2];
              DateTime date = DateTime.parse('$year-$month-$day');

              var object = Schedule(
                id: schedules[i]['id'],
                title: schedules[i]['title'],
                description: schedules[i]['description'],
                startTime: schedules[i]['startTime'],
                endTime: schedules[i]['endTime'],
                color: schedules[i]['color'],
                isCompleted: schedules[i]['isCompleted'],
              );

              var tile = ScheduleTile(
                id: schedules[i]['id'],
                title: schedules[i]['title'],
                description: schedules[i]['description'],
                startTime: schedules[i]['startTime'],
                endTime: schedules[i]['endTime'],
                color: schedules[i]['color'],
                isCompleted: schedules[i]['isCompleted'],
                date: schedules[i]['date'],
                remind: schedules[i]['remind'],
                repeat: schedules[i]['repeat'],
              );

              if (schedules[i]['repeat'] == 'Diariamente') {
                notifyHelper.scheduledNotificationDaily(
                  int.parse(schedules[i]['startTime'].toString().split(":")[0]),
                  int.parse(schedules[i]['startTime'].toString().split(":")[1]),
                  schedules[i]['remind'],
                  object,
                );
                return tile;
              } else if (schedules[i]['repeat'] == 'Semanalmente' && date.weekday == selectedDate.weekday) {
                notifyHelper.scheduledNotificationWeekly(
                  date,
                  int.parse(schedules[i]['startTime'].toString().split(":")[0]),
                  int.parse(schedules[i]['startTime'].toString().split(":")[1]),
                  schedules[i]['remind'],
                  object,
                );
                return tile;
              } else if (schedules[i]['repeat'] == 'Mensalmente' && date.day == selectedDate.day && date.month != selectedDate.month) {
                notifyHelper.scheduledNotificationMonthly(
                  date,
                  int.parse(schedules[i]['startTime'].toString().split(":")[0]),
                  int.parse(schedules[i]['startTime'].toString().split(":")[1]),
                  schedules[i]['remind'],
                  object,
                );
                return tile;
              } else if (schedules[i]['date'] == DateFormat.yMd('pt').format(selectedDate)) {
                if (schedules[i]['date'] == DateFormat.yMd('pt').format(DateTime.now())) {
                  notifyHelper.scheduledNotificationDaily(
                    int.parse(schedules[i]['startTime'].toString().split(":")[0]),
                    int.parse(schedules[i]['startTime'].toString().split(":")[1]),
                    schedules[i]['remind'],
                    object,
                  );
                }
                return tile;
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}