import 'package:flutter/material.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/data/database.dart';
import 'package:schedule/src/screens/home/home.dart';

class Delete extends StatelessWidget {
  const Delete({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).errorColor,
      icon: const Icon(Icons.delete_forever, color: white),
      label: const Text('Excluir', style: TextStyle(color: white)),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirmação'),
              content: const Text('Deseja realmente excluir?'),
              actions: [
                TextButton(
                  child: const Text('Confirmar'),
                  onPressed: () async => await DBHelper.delete(id).then((value) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route) => false);
                    notifier('Evento excluido');
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