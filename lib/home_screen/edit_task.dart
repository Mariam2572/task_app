import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app/firebase_utils.dart';
import 'package:task_app/home_screen/list_task/add_task_bottom_sheet.dart';
import 'package:task_app/model/task.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';

class EditTask extends StatefulWidget {
  static const String routeName = ' Edit task';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Task args = ModalRoute.of(context)?.settings.arguments as Task;
    var provider = Provider.of<AppConfigProvider>(context);
    DateTime newDate = provider.selectDate;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.18,
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.06,
                horizontal: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
              color:provider.isDark()?MyTheme.blackDark: MyTheme.whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.edit_task,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: args.title,
                                hintStyle: TextStyle(
                                    color: provider.isDark()
                                        ? MyTheme.whiteColor
                                        : MyTheme.blackDark)
                                        ),
                            onChanged: (text) {
                              args.title = text;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: args.description,
                                hintStyle: TextStyle(
                                    color: provider.isDark()
                                        ? MyTheme.whiteColor
                                        : MyTheme.blackDark)
                                        ),
                            onChanged: (text) {
                              args.description = text;
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    AppLocalizations.of(context)!.select_date,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: provider.isDark()
                            ? MyTheme.blackDark
                            : MyTheme.whiteColor),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCalender();
                  },
                  child: Text(
                    DateFormat('dd-MM-yyy ').format(newDate),
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.11,
                      horizontal: MediaQuery.of(context).size.width * 0.09),
                  child: ElevatedButton(
                    onPressed: () {
                     
                      Navigator.pop(context, args);
                      setState(() {});
                    },
                    child: Text(AppLocalizations.of(context)!.save_changes),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 133, 181, 244),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      padding: EdgeInsets.all(12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }

    setState(() {});
  }
}
