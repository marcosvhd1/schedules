import 'package:flutter/material.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/src/models/schedule.dart';
import 'package:schedule/src/screens/details/widgets/delete_button.dart';
import 'package:schedule/src/screens/details/widgets/finish_button.dart';
import 'package:schedule/src/widgets/close_button.dart';

class Details extends StatelessWidget {
  const Details(this.schedule, {super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Close(color: white),
        backgroundColor: _getBGClr(schedule.color),
        title: Text(schedule.title, style: const TextStyle(color: white, fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: _getBGClr(schedule.color),
              borderRadius: BorderRadius.circular(50)
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading:const Icon(Icons.title, color: white),
                    title: const Text('Título', style: TextStyle(color: white)),
                    subtitle: Text(schedule.title, style: const TextStyle(color: white)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description, color: white),
                    title: const Text('Descrição', style: TextStyle(color: white)),
                    subtitle: Text(schedule.description, style: const TextStyle(color: white)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_month, color: white),
                    title: const Text('Data', style: TextStyle(color: white)),
                    subtitle: Text(schedule.date, style: const TextStyle(color: white)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: const Icon(Icons.access_time, color: white),
                          title: const Text('Início', style: TextStyle(color: white)),
                          subtitle: Text(schedule.startTime, style: const TextStyle(color: white)),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Fim', style: TextStyle(color: white)),
                          subtitle: Text(schedule.endTime, style: const TextStyle(color: white)),
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
      floatingActionButton: schedule.isCompleted == 0 ? Finish(id: schedule.id, color: _getBGClr(schedule.color)) : Delete(id: schedule.id),
    );
  }
}