import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/data/theme_mode.dart';
import 'package:schedule/src/screens/schedule/add_schedule.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.run});

  final VoidCallback run;

  @override
  Widget build(BuildContext context) {
    final orient = MediaQuery.of(context).orientation;
    final theme = Provider.of<ModelTheme>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd('pt').format(DateTime.now()),
                style: TextStyle(
                  fontSize: orient == Orientation.portrait ? 20.sp : 9.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.isDark ? Colors.grey[400] : Colors.grey,
                ),
              ),
              Text(
                'Hoje',
                style: TextStyle(
                  fontSize: orient == Orientation.portrait ? 20.sp : 9.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ElevatedButton.icon(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
              backgroundColor: MaterialStatePropertyAll(primaryClr)
            ),
            icon: const Icon(Icons.add, color: white),
            label: const Text('Cadastrar', style: TextStyle(color: white)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddSchedule())).then((value) => run()),
          ),
        ],
      ),
    );
  }
}