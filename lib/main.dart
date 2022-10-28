import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/data/theme_mode.dart';
import 'package:schedule/src/screens/home/home.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ModelTheme()),
          ],
          child: Consumer<ModelTheme>(
            builder: (context, ModelTheme theme, child) {
              return MaterialApp(
                title: 'Agenda',
                debugShowCheckedModeBanner: false,
                theme: theme.isDark ? dark : light,
                home: const Home(),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('pt', 'BR'),
                ],
              );
            },
          ),
        );
      },
    );
  }
}