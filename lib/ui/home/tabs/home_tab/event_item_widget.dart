import 'package:evnt_planning_app/model/event.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItemWidget extends StatelessWidget {
  Event event;

  EventItemWidget({required this.event});

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
              event.image,
            ),
            fit: BoxFit.fill),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .02, vertical: height * .015),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white),
                child: Text(
                  event.time,
                  style: AppStyles.bold20Primary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .02, vertical: height * .001),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white),
                child: Column(
                  children: [
                    Text(
                      event.date.day.toString(),
                      style: AppStyles.bold20Primary,
                    ),
                    Text(DateFormat("MMM").format(event.date),
                        style: AppStyles.bold16Primary)
                  ],
                ),
              ),
            ],
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
                  event.title,
                  style: AppStyles.bold18Black,
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
