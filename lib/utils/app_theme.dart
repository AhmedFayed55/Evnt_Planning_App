import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        showUnselectedLabels: true,
        unselectedLabelStyle: AppStyles.bold16White,
        selectedLabelStyle: AppStyles.bold16White,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: StadiumBorder(
            side: BorderSide(
          color: AppColors.white,
          width: 4,
        )),
        backgroundColor: AppColors.primaryLight,
      ));
  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.primaryDark,
      primaryColor: AppColors.primaryDark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        showUnselectedLabels: true,
        unselectedLabelStyle: AppStyles.bold16White,
        selectedLabelStyle: AppStyles.bold16White,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark,
          shape: StadiumBorder(
              side: BorderSide(
            color: AppColors.white,
            width: 4,
          ))));
}
