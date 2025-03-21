import 'package:evnt_planning_app/providers/event_list_provider.dart';
import 'package:evnt_planning_app/providers/user_provider.dart';
import 'package:evnt_planning_app/ui/home/tabs/home_tab/tab_event_widget.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_images.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'event_item_widget.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    eventListProvider.getEventsNameList(context);
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                  userProvider.currentUser!.name,
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
                    Image.asset(AppImages.mapUnSelected),
                    Text(
                      AppLocalizations.of(context)!.cairo_egypt,
                      style: AppStyles.medium14White,
                    )
                  ],
                ),
                DefaultTabController(
                    length: eventListProvider.eventsNameList.length,
                    child: TabBar(
                        onTap: (index) {
                          eventListProvider.changeSelectedIndex(
                              index, userProvider.currentUser!.id);
                        },
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: width * .01, vertical: height * .02),
                        tabAlignment: TabAlignment.start,
                        indicatorColor: AppColors.transparentColor,
                        dividerColor: AppColors.transparentColor,
                        isScrollable: true,
                        tabs: eventListProvider.eventsNameList.map((eventName) {
                          return TabEventWidget(
                              backgroundColor: AppColors.white,
                              textSelectedStyle: AppStyles.medium16Primary,
                              textUnSelectedStyle: AppStyles.medium16White,
                              eventName: eventName,
                              isSelected: eventListProvider.eventsNameList
                                          .indexOf(eventName) ==
                                      eventListProvider.selectedIndex
                                  ? true
                                  : false);
                        }).toList()))
              ],
            ),
          ),
          Expanded(
              child: eventListProvider.filteredList.isEmpty
                  ? Center(
                      child: Text("No Events Yet"),
                    )
                  : ListView.builder(
                      itemCount: eventListProvider.filteredList.length,
                      itemBuilder: (context, index) {
                        return EventItemWidget(
                          event: eventListProvider.filteredList[index],
                        );
                      }))
        ],
      ),
    );
  }
}
