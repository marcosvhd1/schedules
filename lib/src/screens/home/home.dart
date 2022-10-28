import 'package:flutter/material.dart';
import 'package:schedule/src/screens/home/widgets/calendar_picker.dart';
import 'package:schedule/src/screens/home/widgets/header.dart';
import 'package:schedule/src/screens/home/widgets/list_schedules.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Header(),
          CalendarPicker(),
          ListSchedules(),
        ],
      ),
    );
  }
}