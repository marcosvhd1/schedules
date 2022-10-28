import 'package:flutter/material.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/src/models/schedule.dart';
import 'package:schedule/src/screens/details/widgets/delete_button.dart';
import 'package:schedule/src/screens/details/widgets/finish_button.dart';
import 'package:schedule/src/widgets/close_button.dart';

class Details extends StatelessWidget {
  const Details({super.key, required this.schedule});

  final Schedule schedule;

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return yellowClr;
      case 2:
        return pinkClr;
      default:
        return bluishClr;
    }
  }

  Color get color {
    return schedule.color! == 1 ? darkGreyClr : white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Close(color: color),
        backgroundColor: _getBGClr(schedule.color!),
        title: Text(schedule.title!, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: _getBGClr(schedule.color!),
              borderRadius: BorderRadius.circular(50)
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading:Icon(Icons.title, color: color),
                    title: Text('Título', style: TextStyle(color: color)),
                    subtitle: Text(schedule.title!, style: TextStyle(color: color)),
                  ),
                  ListTile(
                    leading: Icon(Icons.description, color: color),
                    title: Text('Descrição', style: TextStyle(color: color)),
                    subtitle: Text(schedule.description!, style: TextStyle(color: color)),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_month, color: color),
                    title: Text('Data', style: TextStyle(color: color)),
                    subtitle: Text(schedule.date!, style: TextStyle(color: color)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Icon(Icons.access_time, color: color),
                          title: Text('Início', style: TextStyle(color: color)),
                          subtitle: Text(schedule.startTime!, style: TextStyle(color: color)),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('Fim', style: TextStyle(color: color)),
                          subtitle: Text(schedule.endTime!, style: TextStyle(color: color)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: schedule.isCompleted == 0 ? Finish(id: schedule.id!, color: _getBGClr(schedule.color!)) : Delete(id: schedule.id!),
    );
  }
}