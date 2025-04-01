import 'package:evnt_planning_app/providers/app_language_provider.dart';
import 'package:evnt_planning_app/providers/app_theme_provider.dart';
import 'package:evnt_planning_app/providers/event_list_provider.dart';
import 'package:evnt_planning_app/providers/user_provider.dart';
import 'package:evnt_planning_app/ui/auth/login/login_screen.dart';
import 'package:evnt_planning_app/ui/auth/register/register_screen.dart';
import 'package:evnt_planning_app/ui/event_map/1st/event_map.dart';
import 'package:evnt_planning_app/ui/home/tabs/home_tab/add_event/add_event.dart';
import 'package:evnt_planning_app/ui/home/tabs/main_screen/main_screen.dart';
import 'package:evnt_planning_app/utils/app_routes.dart';
import 'package:evnt_planning_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork(); // todo: working offline
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
    ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ChangeNotifierProvider(create: (context) => EventListProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
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
      initialRoute: AppRoutes.loginScreenRoute,
      routes: {
        AppRoutes.mainScreenRoute: (context) => MainScreen(),
        AppRoutes.loginScreenRoute: (context) => LoginScreen(),
        AppRoutes.registerScreenRoute: (context) => RegisterScreen(),
        AppRoutes.addEventRoute: (context) => AddEvent(),
        AppRoutes.eventMapRoute: (_) => EventMap(),
      },
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appThemeMode,
    );
  }
}
