import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/data/theme_mode.dart';

class InputForm extends StatelessWidget {
  const InputForm({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.maxLines,
  });

  final String title;
  final String hint;
  final int? maxLines;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ModelTheme>(context);
    final direction = MediaQuery.of(context).orientation;
    final vertical = direction == Orientation.portrait;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: vertical ? 20.h : 35.h),
        Text(title, style: textTitle),
        SizedBox(height: vertical ? 10.h : 25.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          readOnly: widget == null ? false : true,
          validator: (value) {
            if (title == 'Título') if (value!.isEmpty) return 'Campo obrigatório';      

            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: primaryClr),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            filled: true,
            fillColor: theme.isDark ? textFieldDarkColor : textFieldLightColor,
            hintText: hint,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: theme.isDark ? textFieldLightColor : textFieldDarkColor,
            ),
            suffixIcon: widget,
          ),
        ),
      ],
    );
  }
}
