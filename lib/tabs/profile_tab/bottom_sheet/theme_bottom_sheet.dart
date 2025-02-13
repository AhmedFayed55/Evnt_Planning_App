import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppThemeProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSize.height * .02,
          horizontal: screenSize.width * .05),
      child: Column(
        spacing: screenSize.height * .01,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {
                // todo: change Theme to Light
                appTheme.changeThemeMode(ThemeMode.light);
                // todo: pop to hide bottom sheet
                Navigator.pop(context);
              },
              child: appTheme.appThemeMode == ThemeMode.light
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.light)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.light)),
          InkWell(
              onTap: () {
                // todo: change Theme to Dark
                appTheme.changeThemeMode(ThemeMode.dark);
                // todo: pop to hide bottom sheet
                Navigator.pop(context);
              },
              child: appTheme.appThemeMode == ThemeMode.dark
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.dark)),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.bold20Primary),
        Icon(
          Icons.check,
          color: AppColors.primaryLight,
          size: 30,
        )
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(text, style: AppStyles.bold20Black);
  }
}
