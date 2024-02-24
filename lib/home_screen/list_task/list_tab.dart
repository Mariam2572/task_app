// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/firebase_utils.dart';
import 'package:task_app/home_screen/list_task/item_task_list.dart';
import 'package:task_app/model/task.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<AppConfigProvider>(context);
    if (provider.tasksList.isEmpty) {
        provider.getAllTasksFromFireStore();
 
    }
      

    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: provider.selectDate,
          onDateChange: (selectedDate) {
            provider.changeDate(selectedDate);
          },
          activeColor: MyTheme.primary,
          locale: provider.appLanguage,
          dayProps:  EasyDayProps(
            height: MediaQuery.of(context).size.height*.1,
            todayHighlightStyle: TodayHighlightStyle.withBackground,
            todayHighlightColor: Colors.white,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount:provider.tasksList.length,
            itemBuilder: (context, index) {
              return ItemTaskList(task:provider.tasksList[index] ,);
            },
          ),
        )
      ],
    );
  }

 
}
