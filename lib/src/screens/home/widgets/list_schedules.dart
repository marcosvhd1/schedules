import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule/services/notifications_services.dart';
import 'package:schedule/src/controllers/schedule_controller.dart';
import 'package:schedule/src/screens/home/widgets/calendar_picker.dart';
import 'package:schedule/src/screens/home/widgets/schedule_tile.dart';

class ListSchedules extends StatefulWidget {
  const ListSchedules({super.key});

  @override
  State<ListSchedules> createState() => _ListSchedulesState();
}

class _ListSchedulesState extends State<ListSchedules> {
  final NotifyHelper _notifyHelper = NotifyHelper();

  @override
  void initState() {
    _notifyHelper.initializeNotification();
    _notifyHelper.requestIOSPermissions();
    loadSchedules();
    super.initState();
  }

  void loadSchedules() {
    final provider = Provider.of<ScheduleController>(context, listen: false);
    provider.getSchedules();
  }

  @override
  Widget build(BuildContext context) {
    final orient = MediaQuery.of(context).orientation;
    final vertical = orient == Orientation.portrait;
    final schedules = Provider.of<ScheduleController>(context).schedules;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: vertical ? 10.h : 30.h),
        itemCount: schedules.length,
        itemBuilder: (c, i) {
          String day = schedules[i].date.toString().split('/')[0];
          String month = schedules[i].date.toString().split('/')[1];
          String year = schedules[i].date.toString().split('/')[2];
          DateTime date = DateTime.parse('$year-$month-$day');

          int hour = int.parse(schedules[i].startTime.toString().split(":")[0]);
          int minutes = int.parse(schedules[i].startTime.toString().split(":")[1]);

          if (schedules[i].repeat == 'Diariamente') {
            if (schedules[i].isCompleted == 0) {
              _notifyHelper.scheduledNotification(date, hour, minutes, schedules[i], type: 'Daily');
            }

            return ScheduleTile(schedules[i]);
          } else if (schedules[i].repeat == 'Semanalmente' && date.weekday == CalendarPickerState.selectedDate.weekday) {
            if (schedules[i].isCompleted == 0) {
              _notifyHelper.scheduledNotification(date, hour, minutes, schedules[i], type: 'Weekly');
            }

            return ScheduleTile(schedules[i]);
          } else if (schedules[i].repeat == 'Mensalmente' && date.day == CalendarPickerState.selectedDate.day && date.month != CalendarPickerState.selectedDate.month) {
            if (schedules[i].isCompleted == 0) {
              _notifyHelper.scheduledNotification(date, hour, minutes, schedules[i], type: 'Monthly');
            }

            return ScheduleTile(schedules[i]);
          } else if (schedules[i].date == DateFormat.yMd('pt').format(CalendarPickerState.selectedDate)) {
              if (schedules[i].isCompleted == 0) {
                if (schedules[i].date == DateFormat.yMd('pt').format(DateTime.now())) {
                  _notifyHelper.scheduledNotification(date, hour, minutes, schedules[i], type: 'Daily');
                }
              }
            return ScheduleTile(schedules[i]);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}