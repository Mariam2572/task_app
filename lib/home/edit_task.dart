import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app/firebase_utils.dart';
import 'package:task_app/home/list_task/add_task_bottom_sheet.dart';
import 'package:task_app/model/task.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/providers/auth_provider.dart';
import 'package:task_app/theme.dart';

class EditTask extends StatefulWidget {
  static const String routeName = ' Edit task';

final Task task;

  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController titleController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text=widget.task.title!;
    descriptionController.text = widget.task.description!;
  }
  @override
  Widget build(BuildContext context) {
                 var provider = Provider.of<AppConfigProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.18,
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.06,
                horizontal: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
              color: provider.isDark() ? MyTheme.blackDark : MyTheme.whiteColor,
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        onChanged: (value) {
                          titleController.text =value;
                        },
                        controller: titleController,
                        decoration: InputDecoration(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                         onChanged: (value) {
                          descriptionController.text =value;
                        },
                        controller:descriptionController ,
                        decoration: InputDecoration(),
                      ),
                    ),
                  ],
                ),
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
                    DateFormat('dd-MM-yyy ').format(provider.selectDate),
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
                    onPressed: ()  {
                      FirebaseUtils.updateTask(widget.task, widget.task.id!);
                     if(mounted) Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.save_changes),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 133, 181, 244),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    // if (chosenDate != null) {
    //   widget.newDate = chosenDate;
    // } 
   
  }
  }
