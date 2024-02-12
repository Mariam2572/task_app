import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode appTheme =ThemeMode.light;
  changeLanguage(String newLanguage ){
    if (appLanguage == newLanguage) {
      return;
    } 
    appLanguage =newLanguage ;
    notifyListeners();
  } 
  changeTheme(ThemeMode newTheme){
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();

  }
   bool isDark(){
    return appTheme ==ThemeMode.dark;
  }
}