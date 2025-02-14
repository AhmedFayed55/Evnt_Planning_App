import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  Color? borderColor;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  TextStyle? style;
  Widget? prefixIcon;
  Widget? sufixIcon;
  Color? prefixIconColor;
  Color? cursorColor;
  int? maxLines;
  String? Function(String?)? validator;
  TextEditingController? controller;

  CustomTextField(
      {this.borderColor,
      required this.hintText,
      this.labelText,
      this.hintStyle,
      this.labelStyle,
      this.prefixIcon,
      this.sufixIcon,
      this.style,
      this.prefixIconColor,
      this.maxLines,
      this.validator,
      this.controller,
      this.cursorColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      style: style,
      decoration: InputDecoration(
          prefixIconColor: prefixIconColor ?? AppColors.grey,
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          hintText: hintText,
          labelText: labelText,
          hintStyle: hintStyle ?? AppStyles.medium16Grey,
          labelStyle: labelStyle ?? AppStyles.medium16Grey,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: borderColor ?? AppColors.grey, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(color: borderColor ?? AppColors.grey, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red, width: 2))),
    );
  }
}
