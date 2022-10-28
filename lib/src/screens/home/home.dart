import 'package:flutter/material.dart';
import 'package:schedule/src/screens/home/widgets/content.dart';
import 'package:schedule/src/screens/home/widgets/toggle_theme.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const ToggleTheme()),
      body: const Content(),
    );
  }
}
