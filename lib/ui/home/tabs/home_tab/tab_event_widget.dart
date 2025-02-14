import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TabEventWidget extends StatelessWidget {
  String eventName;
  bool isSelected;
  Color backgroundColor;
  TextStyle textSelectedStyle;
  TextStyle textUnSelectedStyle;
  Color? borderColor;

  TabEventWidget(
      {required this.eventName,
      required this.textSelectedStyle,
      required this.textUnSelectedStyle,
      this.borderColor,
      required this.isSelected,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * .04, vertical: height * .012),
      decoration: BoxDecoration(
          color: isSelected ? backgroundColor : AppColors.transparentColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor ?? AppColors.white, width: 2)),
      child: Text(
        eventName,
        style: isSelected ? textSelectedStyle : textUnSelectedStyle,
      ),
    );
  }
}
