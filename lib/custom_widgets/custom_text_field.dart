import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomTextField extends StatefulWidget {
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
  bool obscureText;
  bool showSufixIcon;
  TextInputType? keyboardType;

  CustomTextField(
      {this.borderColor,
      required this.hintText,
      this.labelText,
      this.obscureText = false,
      this.showSufixIcon = false,
      this.hintStyle,
      this.labelStyle,
      this.prefixIcon,
      this.sufixIcon,
      this.keyboardType,
      this.style,
      this.prefixIconColor,
      this.maxLines = 1,
      this.validator,
      this.controller,
      this.cursorColor});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      cursorColor: widget.cursorColor,
      controller: widget.controller,
      validator: widget.validator,
      maxLines: widget.maxLines,
      style: widget.style,
      decoration: InputDecoration(
          prefixIconColor: widget.prefixIconColor ?? AppColors.grey,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.showSufixIcon
              ? IconButton(
                  onPressed: () {
                    widget.obscureText = !widget.obscureText;
                    setState(() {});
                  },
                  icon: Icon(widget.obscureText
                      ? Icons.visibility_off
                      : Icons.visibility))
              : null,
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: widget.hintStyle ?? AppStyles.medium16Grey,
          labelStyle: widget.labelStyle ?? AppStyles.medium16Grey,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.grey, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.grey, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red, width: 2))),
    );
  }
}
