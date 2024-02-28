import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/firebase_utils.dart';
import 'package:task_app/model/task.dart';

class AppConfigProvider extends ChangeNotifier {
  // الداتا اللي لما هتتغير هتأثر على أكتر من ويدجت
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();
  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTaskCollection(uId).get();
    //  List<QueryDocumentSnapshot<Task>> //doc اللي شايله التاسكات=> List<Task>
    tasksList = querySnapshot.docs.map((doc) => doc.data()).toList();
// filter all tasks
// where بتاخد الليست وتفلترها لليسته تانية جديدة
    tasksList = tasksList.where(
      (task) {
        if (selectDate.day == task.dateTime?.day &&
            selectDate.month == task.dateTime?.month &&
            selectDate.year == task.dateTime?.year) {
          return true;
        }
        return false;
      },
    ).toList();
// FirebaseUtils.getTaskCollection().orderBy('dateTime', descending: true).get().timeout(onTimeout: () {
//   return getAllTasksFromFireStore();
// },)
// tasksList.sort((task1, task2) {
//   return task1.dateTime!.compareTo(task2.dateTime!);

// },);

    notifyListeners();
  }

  void changeDate(DateTime newDate , String uId) {
    selectDate = newDate;
    // refresh tasks after filter date
    getAllTasksFromFireStore(uId);
    //removed to improve performance
    // notifyListeners();
  }

  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("newLanguage", appLanguage);
    notifyListeners();
  }

  changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("newTheme", appTheme.name);
    notifyListeners();
  }
  Future<void> loadSettings() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String? newTheme = prefs.getString("newTheme");
        //String? newLanguage = prefs.getString("newLanguage");
       newTheme ??="light"; 
       appTheme =( newTheme == "dark" ? ThemeMode.dark : ThemeMode.light);
      //  newLanguage ??= "en";
      //   appLanguage = newLanguage;
        notifyListeners();

  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }
}
