import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:task_app/auth/login/login.dart';
import 'package:task_app/auth/register/register.dart';
import 'package:task_app/home_screen/edit_task.dart';
import 'package:task_app/home_screen/home_screen.dart';
import 'package:task_app/home_screen/list_task/item_task_list.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var provider =AppConfigProvider();
  await provider.loadSettings();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(ChangeNotifierProvider(
      create: (context) {
        return provider;
      },
      child: ToDoApp()));
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
       navigatorKey: navigatorKey,
       builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
           LoginScreen.routeName:(context) => LoginScreen(),
        RegisterScreen.routeName :(context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTask.routeName :(context) => EditTask(),
     
        // ItemTaskList.routeName :(context) => ItemTaskList(task: task);
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
/*
 showDialog(context: context, builder: (context) {
         return const AlertDialog(
          title: Text('Success',style: TextStyle(color: Colors.black),),
          content: Text('task Added Successfully'),
          
         );
*/