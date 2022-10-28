import 'package:flutter/material.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/data/database.dart';
import 'package:schedule/src/screens/home/home.dart';

class Finish extends StatelessWidget {
  const Finish({super.key, required this.id, required this.color});

  final int id;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: color,
      icon: Icon(Icons.event_available, color: color == yellowClr ? darkGreyClr : white),
      label: Text('Finalizar', style: TextStyle(color: color == yellowClr ? darkGreyClr : white)),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirmação'),
              content: const Text('Concluir evento?'),
              actions: [
                TextButton(
                  child: const Text('Confirmar'),
                  onPressed: () async => await DBHelper.updateIsCompleted(id, 1) .then((value) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route) => false);
                    notifier('Evento finalizado');
                  }),
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
        );
      },
    );
  }
}