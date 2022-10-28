import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/src/controllers/schedule_controller.dart';
import 'package:schedule/src/screens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (_) => ScheduleController(),
          child: MaterialApp(
            title: 'Agenda',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: light,
            darkTheme: dark,
            home: const Home(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('pt', 'BR'),
            ],
          ),
        );
      },
    );
  }
}
