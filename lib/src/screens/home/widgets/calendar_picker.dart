// ignore_for_file: must_be_immutable

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/src/controllers/schedule_controller.dart';

class CalendarPicker extends StatefulWidget {
  const CalendarPicker({super.key});

  @override
  State<CalendarPicker> createState() => CalendarPickerState();
}

class CalendarPickerState extends State<CalendarPicker> {
  static DateTime selectedDate = DateTime.now();

  void changeDate(DateTime date) {
    selectedDate = date;
    
    final provider = Provider.of<ScheduleController>(context, listen: false);
    provider.getSchedules();
  }

  @override
  Widget build(BuildContext context) {
    final orient = MediaQuery.of(context).orientation;
    final vertical = orient == Orientation.portrait;
    return Padding(
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
        onDateChange: (date) => changeDate(date),
      ),
    );
  }
}