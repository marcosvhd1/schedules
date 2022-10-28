import 'package:flutter/material.dart';
import 'package:schedule/constants/constants.dart';

class Close extends StatelessWidget {
  const Close({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = MediaQuery.of(context).platformBrightness;
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: color ?? (theme == Brightness.dark ? white : darkGreyClr),
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}