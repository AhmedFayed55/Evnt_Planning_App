import 'package:evnt_planning_app/custom_widgets/custom_text_field.dart';
import 'package:evnt_planning_app/providers/event_list_provider.dart';
import 'package:evnt_planning_app/ui/home/tabs/home_tab/event_item_widget.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_images.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if (eventListProvider.favoriteEventsList.isEmpty) {
      eventListProvider.getFavoriteEvents(userProvider.currentUser!.id);
    }
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .032),
        child: Column(
          spacing: height * .005,
          children: [
            CustomTextField(
              hintStyle: AppStyles.bold16Primary,
              style: AppStyles.bold16Primary,
              borderColor: AppColors.primaryLight,
              hintText: AppLocalizations.of(context)!.search_for_event,
              prefixIcon: Image.asset(AppImages.search),
            ),
            Expanded(
              child: eventListProvider.favoriteEventsList.isEmpty
                  ? Center(
                      child:
                          Text(AppLocalizations.of(context)!.search_for_event),
                    )
                  : ListView.builder(
                      itemCount: eventListProvider.favoriteEventsList.length,
                      itemBuilder: (context, index) {
                        return EventItemWidget(
                            event: eventListProvider.favoriteEventsList[index]);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
