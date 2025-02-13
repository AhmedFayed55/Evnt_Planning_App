import 'package:evnt_planning_app/ui/home/tabs/home_tab/tab_event_widget.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:evnt_planning_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'event_item_widget.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    // List<String> stringEventsName = [
    //   "Sport",
    //   "Birthday",
    //   "Meeting",
    //   "Gaming",
    //   "Work Shop",
    //   "Book Club",
    //   "Exhibition",
    //   "Holiday",
    //   "Eating",
    // ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyles.regular14White,
                ),
                Text(
                  "Ahmed Fayed",
                  style: AppStyles.bold24White,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.light_mode,
                  color: AppColors.white,
                  size: 30,
                ),
                SizedBox(
                  width: width * .02,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: height * .008, horizontal: width * .02),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "EN",
                    style: AppStyles.bold14Primary,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * .03, vertical: height * .003),
            height: height * .14,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AssetsManager.mapUnSelected),
                    Text(
                      AppLocalizations.of(context)!.cairo_egypt,
                      style: AppStyles.medium14White,
                    )
                  ],
                ),
                DefaultTabController(
                    length: eventsNameList.length,
                    child: TabBar(
                        onTap: (index) {
                          selectedIndex = index;
                          setState(() {});
                        },
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: width * .01, vertical: height * .02),
                        tabAlignment: TabAlignment.start,
                        indicatorColor: AppColors.transparentColor,
                        dividerColor: AppColors.transparentColor,
                        isScrollable: true,
                        tabs: eventsNameList.map((eventName) {
                          return TabEventWidget(
                              eventName: eventName,
                              isSelected: eventsNameList.indexOf(eventName) ==
                                      selectedIndex
                                  ? true
                                  : false);
                        }).toList()))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return EventItemWidget();
                  }))
        ],
      ),
    );
  }
}
