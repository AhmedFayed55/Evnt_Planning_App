import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:evnt_planning_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class EventItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          top: height * .02, right: width * .03, left: width * .03),
      padding:
          EdgeInsets.symmetric(horizontal: width * .02, vertical: height * .01),
      height: height * .25,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryLight, width: 1.5),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: AssetImage(
              AssetsManager.birthday,
            ),
            fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * .02, vertical: height * .001),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white),
            child: Column(
              children: [
                Text(
                  "22",
                  style: AppStyles.bold20Primary,
                ),
                Text(
                  "Nov",
                  style: AppStyles.bold16Primary,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * .02, vertical: height * .01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "This is a birthday party",
                  style: AppStyles.bold14Black,
                ),
                Icon(
                  Icons.favorite_border_rounded,
                  color: AppColors.primaryLight,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
