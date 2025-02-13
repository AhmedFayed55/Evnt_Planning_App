import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  Widget? prefixIconButton;
  Color? backgroundColor;
  String text;
  TextStyle? textStyle;
  Function onTap;

  CustomElevatedButton(
      {this.backgroundColor,
      this.prefixIconButton,
      required this.text,
      this.textStyle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: backgroundColor ?? AppColors.primaryLight,
            padding: EdgeInsets.symmetric(
                vertical: height * .018, horizontal: width * .05)),
        onPressed: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIconButton ?? SizedBox(),
            SizedBox(
              width: width * 0.025,
            ),
            Text(
              text,
              style: textStyle ?? AppStyles.regular20white,
            )
          ],
        ));
  }
}
