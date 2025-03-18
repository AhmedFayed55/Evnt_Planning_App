import 'package:evnt_planning_app/ui/home/tabs/favorite_tab/favorite_tab.dart';
import 'package:evnt_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../home_tab/home_tab.dart';
import '../map_tab/map_tab.dart';
import '../profile_tab/profile.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), MapTab(), FavoriteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data:
            Theme.of(context).copyWith(canvasColor: AppColors.transparentColor),
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          padding: EdgeInsets.zero,
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                buildBottomNavItem(
                    index: 0,
                    lable: AppLocalizations.of(context)!.home,
                    iconName: AppImages.homeUnSelected,
                    selectedIconName: AppImages.homeSelected),
                buildBottomNavItem(
                    index: 1,
                    lable: AppLocalizations.of(context)!.map,
                    iconName: AppImages.mapUnSelected,
                    selectedIconName: AppImages.mapSelected),
                buildBottomNavItem(
                    index: 2,
                    lable: AppLocalizations.of(context)!.favorite,
                    iconName: AppImages.loveUnSelected,
                    selectedIconName: AppImages.loveSelected),
                buildBottomNavItem(
                    index: 3,
                    lable: AppLocalizations.of(context)!.profile,
                    iconName: AppImages.profileUnSelected,
                    selectedIconName: AppImages.profileSelected)
              ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // todo: add event
          // todo: navigator to add event screen
          Navigator.of(context).pushNamed(AppRoutes.addEventRoute);
        },
        child: Icon(
          Icons.add,
          size: 42,
          color: AppColors.white,
        ),
      ),
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavItem(
      {required int index,
      required String selectedIconName,
      required String lable,
      required String iconName}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(index == selectedIndex ? selectedIconName : iconName)),
        label: lable);
  }
}
