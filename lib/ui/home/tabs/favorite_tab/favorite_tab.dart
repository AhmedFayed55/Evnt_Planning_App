import 'package:evnt_planning_app/custom_widgets/custom_text_field.dart';
import 'package:evnt_planning_app/utils/app_colors.dart';
import 'package:evnt_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: Column(
          children: [
            CustomTextField(
              hintText: AppLocalizations.of(context)!.search_for_event,
              hintStyle: AppStyles.bold14Primary,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.primaryLight,
              ),
              borderColor: AppColors.primaryLight,
              cursorColor: AppColors.primaryLight,
            ),
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              return Container();
            }))
          ],
        ),
      ),
    );
  }
}
