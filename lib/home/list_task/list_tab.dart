import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/home/list_task/item_task_list.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/providers/auth_provider.dart';
import 'package:task_app/theme.dart';

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProviders>(context);
    var provider = Provider.of<AppConfigProvider>(context);
    if (provider.tasksList.isEmpty) {
      provider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: MyTheme.primary),
          child: EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              provider.changeDate(selectedDate, authProvider.currentUser!.id!);
            },
            activeColor: MyTheme.whiteColor,
            locale: provider.appLanguage,
            headerProps: const EasyHeaderProps(
              centerHeader: false,
              selectedDateStyle: TextStyle(
                fontWeight: FontWeight.w500,
              ),
              dateFormatter: DateFormatter.monthOnly(),
            ),
            dayProps: EasyDayProps(
              todayStyle:
                  DayStyle(monthStrStyle: TextStyle(color: MyTheme.whiteColor)),
              height: 56.0,
              width: 56.0,
              dayStructure: DayStructure.dayNumDayStr,
              inactiveDayStyle: DayStyle(
                borderRadius: 15.0,
                dayNumStyle: TextStyle(
                  color: provider.isDark()
                      ? MyTheme.whiteColor
                      : MyTheme.blackDark,
                  fontSize: 18.0,
                ),
              ),
              activeDayStyle: const DayStyle(
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: provider.tasksList.length,
            itemBuilder: (context, index) {
              return ItemTaskList(
                task: provider.tasksList[index],
              );
            },
          ),
        )
      ],
    );
  }
}
