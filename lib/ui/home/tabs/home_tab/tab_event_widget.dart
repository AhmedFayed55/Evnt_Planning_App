import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class TabEventWidget extends StatelessWidget {
  String eventName;
  bool isSelected;

  TabEventWidget({required this.eventName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * .04, vertical: height * .012),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.transparentColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.white, width: 2)),
      child: Text(
        eventName,
        style: isSelected ? AppStyles.medium16Primary : AppStyles.medium16White,
      ),
    );
  }
}
