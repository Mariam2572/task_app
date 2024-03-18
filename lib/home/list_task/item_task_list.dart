// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app/dialog_utils.dart';
import 'package:task_app/firebase_utils.dart';
import 'package:task_app/home/edit_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:task_app/model/task.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/providers/auth_provider.dart';
import 'package:task_app/theme.dart';

class ItemTaskList extends StatefulWidget {
  bool click = true;
  // static const String routeName = 'item task';

  Task task;
  ItemTaskList({
    required this.task,
  });

  @override
  State<ItemTaskList> createState() => _ItemTaskListState();
}

class _ItemTaskListState extends State<ItemTaskList> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);

    bool isdone = widget.task.isDone!;
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        key: UniqueKey(),
        startActionPane:
            ActionPane(extentRatio: .25, motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) => {
              FirebaseUtils.deleteTaskFromFireStore(
                      widget.task, authProvider.currentUser!.id!)
                  .then((value) {
                print('task deleted successfully');
                provider
                    .getAllTasksFromFireStore(authProvider.currentUser!.id!);
              })
            },
            backgroundColor: MyTheme.redColor,
            foregroundColor: MyTheme.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(5),
                topRight: Radius.circular(5)),
            icon: Icons.delete,
            label: 'Delete',
          )
        ]),
        child: InkWell(
          onTap: () {
              Navigator.of(context).
              push(CupertinoPageRoute(builder: (context) => EditTask(task: widget.task),));
                    
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color:
                    provider.isDark() ? MyTheme.blackDark : MyTheme.whiteColor,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 4,
                  height: MediaQuery.of(context).size.height * .10,
                  decoration: BoxDecoration(
                      color: (widget.click == false)
                          ? MyTheme.greenColor
                          : MyTheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: (widget.click == false)
                              ? MyTheme.greenColor
                              : MyTheme.primary),
                    ),
                    Text(
                      widget.task.description ?? '',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: (widget.click == false)
                              ? MyTheme.greenColor
                              : provider.isDark()
                                  ? MyTheme.primary
                                  : MyTheme.blackLight),
                    ),
                    Row(children: [
                      Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: provider.isDark()
                            ? MyTheme.whiteColor
                            : MyTheme.blackLight,
                      ),
                      Text(
                        DateFormat('dd-MM-yyy ').format(provider.selectDate),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ]),
                  ],
                )),
                widget.click == true
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.click = !widget.click;
                          });
                         if(widget.task.isDone == true) return;
                         widget.task.isDone = true;
                         FirebaseUtils.updateTask(widget.task, widget.task.id!);
                        },
                        child: const ImageIcon(
                          AssetImage('assets/images/icon_check.png'),
                          size: 35,
                        ))
                    : Text(
                        AppLocalizations.of(context)!.done,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: MyTheme.greenColor),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}