import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/data/theme_mode.dart';

class Close extends StatelessWidget {
  const Close({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ModelTheme>(context);
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: color ?? (theme.isDark ? white : darkGreyClr),
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}