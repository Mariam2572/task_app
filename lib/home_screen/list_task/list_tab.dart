import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/home_screen/list_task/item_task_list.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';
// import 'package:task_app/home_screen/list_task/item_task_list.dart';
// import 'package:easy_date_timeline/easy_date_timeline.dart';
// import 'package:easy_date_timeline/easy_date_timeline.dart';
class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  
  @override
  Widget build(BuildContext context) {
        var provider =Provider.of<AppConfigProvider>(context);

    return Container(
      child: Column(
        children: [
       EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //`selectedDate` the new date selected.
      },
      activeColor: MyTheme.primary,
      locale: provider.appLanguage,
      dayProps: const EasyDayProps(
        todayHighlightStyle: TodayHighlightStyle.withBackground,
        todayHighlightColor: Colors.white,
      ),
    ) ,
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
            return ItemTaskList();
          },),
        )
        ],
       
      ),
     );
  }
}
