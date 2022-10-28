import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/constants/constants.dart';

class ColorPalette extends StatefulWidget {
  const ColorPalette({super.key});

  @override
  State<ColorPalette> createState() => ColorPaletteState();
}

class ColorPaletteState extends State<ColorPalette> {

  static int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      children: List.generate(3, (i) {
          return InkWell(
            onTap: () => setState(() => selectedColor = i),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: i == 0 ? primaryClr : i == 1 ? yellowClr : pinkClr,
              child: selectedColor == i ? const Icon(Icons.done, color: white) : null,
            ),
          );
        },
      ),
    );
  }
}