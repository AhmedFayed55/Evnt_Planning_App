import 'package:evnt_planning_app/providers/app_language_provider.dart';
import 'package:evnt_planning_app/providers/app_theme_provider.dart';
import 'package:evnt_planning_app/tabs/main_screen/main_screen.dart';
import 'package:evnt_planning_app/tabs/profile_tab/profile.dart';
import 'package:evnt_planning_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AppLanguageProvider(),
    ),
    ChangeNotifierProvider(create: (context) => AppThemeProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: MainScreen.routeName,
      routes: {
        ProfileTab.routeName: (context) => ProfileTab(),
        MainScreen.routeName: (context) => MainScreen()
      },
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appThemeMode,
    );
  }
}
