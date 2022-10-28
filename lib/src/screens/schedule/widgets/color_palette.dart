import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/src/screens/schedule/add_schedule.dart';

class ColorPalette extends StatefulWidget {
  const ColorPalette({super.key});

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      children: List.generate(3, (i) {
          return InkWell(
            onTap: () => setState(() => context.findAncestorStateOfType<AddScheduleState>()?.selectedColor = i),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: i == 0 ? primaryClr : i == 1 ? yellowClr : pinkClr,
              child: context.findAncestorStateOfType<AddScheduleState>()?.selectedColor == i ? const Icon(Icons.done, color: white) : null,
            ),
          );
        },
      ),
    );
  }
}