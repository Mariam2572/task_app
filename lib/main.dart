import 'package:flutter/material.dart';
import 'package:task_app/home_screen/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';

void main(){
  runApp(ChangeNotifierProvider(
    create: (context) {
      return AppConfigProvider();
    },
    child: ToDoApp()));
}
class ToDoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName :(context) => HomeScreen(),
      },
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkMode,
      themeMode: provider.appTheme,
        locale: Locale(provider.appLanguage),
         localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}