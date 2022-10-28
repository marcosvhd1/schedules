
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/src/controllers/schedule_controller.dart';

class Delete extends StatelessWidget {
  const Delete({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleController>(context, listen: false);
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).errorColor,
      icon: const Icon(Icons.delete_forever, color: white),
      label: const Text('Excluir', style: TextStyle(color: white)),
      onPressed: () async {
        bool confirm = false;
        await showDialog(
          context: context,
          builder: (c) {
            return AlertDialog(
              title: const Text('Confirmação'),
              content: const Text('Deseja realmente excluir?'),
              actions: [
                TextButton(
                  child: const Text('Confirmar'),
                  onPressed: () async {
                    await provider.deleteSchedule(id).then((value) {
                      Navigator.pop(context);
                      notifier('Evento excluido');
                    });
                    confirm = true;
                  } 
                ),
                TextButton(
                  child: const Text('Cancelar'),
                   onPressed: () {
                    Navigator.pop(context);
                  },  
                ),
              ],
            );
          },
        ).then((value) => confirm ? Navigator.pop(context) : null);
      },
    );
  }
}