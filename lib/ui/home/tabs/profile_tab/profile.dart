import 'package:evnt_planning_app/custom_widgets/custom_elevated_button.dart';
import 'package:evnt_planning_app/custom_widgets/dialoug_utils.dart';
import 'package:evnt_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_styles.dart';
import 'bottom_sheet/language_botom_sheet.dart';
import 'bottom_sheet/theme_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * .18,
        backgroundColor: AppColors.primaryLight,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(65))),
        title: Row(
          children: [
            Image.asset(AppImages.profile_Tab_App_Bar),
            SizedBox(
              width: screenSize.width * .05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Route Academy",
                  style: AppStyles.bold24White,
                ),
                SizedBox(
                  height: screenSize.height * .005,
                ),
                Text("route@gmail.com", style: AppStyles.medium16White),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * .04,
            vertical: screenSize.height * .028),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: screenSize.height * .02,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: themeProvider.appThemeMode == ThemeMode.light
                  ? AppStyles.bold20Black
                  : AppStyles.bold20White,
            ),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 2,
                      color: AppColors.primaryLight,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.appLanguage == "en"
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: AppStyles.bold20Primary,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: themeProvider.appThemeMode == ThemeMode.light
                  ? AppStyles.bold20Black
                  : AppStyles.bold20White,
            ),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 2,
                      color: AppColors.primaryLight,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.appThemeMode == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: AppStyles.bold20Primary,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryLight,
                      size: 35,
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            CustomElevatedButton(
                backgroundColor: AppColors.red,
                prefixIconButton: Icon(
                  Icons.logout,
                  color: AppColors.white,
                ),
                text: AppLocalizations.of(context)!.logout,
                onTap: onLogoutClick),
            SizedBox(
              height: screenSize.height * .002,
            )
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return LanguageBottomSheet();
        });
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ThemeBottomSheet();
        });
  }

  void onLogoutClick() {
    DialogueUtils.showMessage(
        context: context,
        message: "Log out of your account?",
        posActionName: "Cancel",
        ngeActionName: "LOG OUT",
        posAction: () {
          Navigator.of(context).pop();
        },
        ngeAction: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.loginScreenRoute, (route) => false);
        });
  }
}
