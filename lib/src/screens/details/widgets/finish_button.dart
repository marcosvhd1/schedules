import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/services/notifications_services.dart';
import 'package:schedule/src/controllers/schedule_controller.dart';

class Finish extends StatelessWidget {
  const Finish({super.key, required this.id, required this.color});

  final int id;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleController>(context, listen: false);
    return FloatingActionButton.extended(
      backgroundColor: color,
      icon: Icon(Icons.event_available, color: color == yellowClr ? darkGreyClr : white),
      label: Text('Finalizar', style: TextStyle(color: color == yellowClr ? darkGreyClr : white)),
      onPressed: () async {
        bool confirm = false;
        await showDialog(
          context: context,
          builder: (c) {
            return AlertDialog(
              title: const Text('Confirmação'),
              content: const Text('Concluir evento?'),
              actions: [
                TextButton(
                  child: const Text('Confirmar'),
                  onPressed: () async {
                    confirm = true;
                    await provider.finishSchedule(id);

                    final NotifyHelper notifyHelper = NotifyHelper();
                    await notifyHelper.cancelScheduleNotification(id).then((value) => Navigator.pop(context));
                    notifier('Evento finalizado');
                  }
                ),
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.pop(context),  
                ),
              ],
            );
          },
        ).then((value) => confirm ? Navigator.pop(context) : null);
      },
    );
  }
}