import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

const textFieldLightColor = Color(0xFFebebeb);
const textFieldDarkColor = Color(0xFF29292e);

final light = ThemeData(
  appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0),
  fontFamily: 'Lato',
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryClr,
  ),
);

final dark = ThemeData(
  appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0),
  fontFamily: 'Lato',
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: primaryClr,
  ),
);

TextStyle get dateStyle {
  return const TextStyle(
    color: Colors.grey,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}

TextStyle get dayStyle {
  return const TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

TextStyle get monthStyle {
  return const TextStyle(
    color: Colors.grey,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}

TextStyle get headerTitle {
  return const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get textTitle {
  return const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

void navigator(BuildContext context, Widget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
}

void notifier(String message, [bool error = false]) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: error ? pinkClr : null,
    textColor: white,
  );
}