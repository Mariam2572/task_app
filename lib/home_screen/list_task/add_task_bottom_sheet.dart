import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}
    var selectedDate = DateTime.now();
    var formKey =GlobalKey<FormState>();
    String title= '';
    String details= '';

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
        var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_task,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formKey ,
            child: 
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
           Padding(
            padding:  EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (text) {
                title =text;
              },
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return AppLocalizations.of(context)!.validate_message1;
                }
                return null;
                
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: provider.isDark()?MyTheme.whiteColor:MyTheme.greyColor
                  )
                ),
                  hintText: AppLocalizations.of(context)!.enter_task_title,
                  hintStyle: Theme.of(context).textTheme.titleSmall),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (text) {
                details =text;
              },
               validator: (text) {
                if (text == null || text.isEmpty) {
                  return AppLocalizations.of(context)!.validate_message2;
                }
                return null;
                
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: provider.isDark()?MyTheme.whiteColor:MyTheme.greyColor
                  )
                ),
                  hintText: AppLocalizations.of(context)!.enter_task_details,
                  hintStyle: Theme.of(context).textTheme.titleSmall),
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              AppLocalizations.of(context)!.select_date,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color:provider.isDark()?MyTheme.whiteColor: MyTheme.blackLight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                showCalender();
              },
              child: Text(
                 DateFormat('dd-MM-yyy ').format(selectedDate),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w200, fontSize: 15),
              ),
            ),
          ),
         
            ],
          )),
         ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.primary,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(8),
                  side: BorderSide(color: MyTheme.whiteColor, width: 4)),
              onPressed: () {
                addTask();
              },
              child: ImageIcon(
                AssetImage('assets/images/icon_check.png'),
                size: 35,
              ))
        ],
      ),
    );
  }

  void showCalender() async {
   var chosenDate=await showDatePicker(context: context,
     initialDate: DateTime.now(),
      firstDate: DateTime.now(),
       lastDate: DateTime.now().add(Duration(days: 365)));
       if (chosenDate != null) {
         selectedDate=chosenDate;
       }
       setState(() {
         
       });
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      /// add task
    }
  }
}
