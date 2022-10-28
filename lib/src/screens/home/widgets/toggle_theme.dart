import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/data/theme_mode.dart';

class ToggleTheme extends StatelessWidget {
  const ToggleTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (c, ModelTheme theme, ch) {
        return IconButton(
          tooltip: 'Alterar tema',
          icon: Icon(
            theme.isDark ? Icons.dark_mode : Icons.light_mode,
            color: theme.isDark ? white : darkGreyClr,
          ),
          onPressed: () =>
              theme.isDark ? theme.isDark = false : theme.isDark = true,
        );
      },
    );
  }
}
