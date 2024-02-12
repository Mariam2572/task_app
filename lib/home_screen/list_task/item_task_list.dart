import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemTaskList extends StatelessWidget {
    var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
        var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color:provider.isDark()?MyTheme.blackDark: MyTheme.whiteColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text('data'),
          Container(
            width: 4,
            height: MediaQuery.of(context).size.height * .10,
            decoration: BoxDecoration(
                color: MyTheme.primary,
                borderRadius: BorderRadius.circular(10)),
          ),
      SizedBox(width: 10,),
        Expanded(
         
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.task,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color:provider.isDark()? MyTheme.primary:MyTheme.blackLight),
            ),
             Text(
                 DateFormat('dd-MM-yyy ').format(selectedDate),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.w300, fontSize: 12),
              ),
          ],
        )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                    
              ),
              onPressed: () {},
              child: ImageIcon(
                AssetImage('assets/images/icon_check.png'),
                size: 35,
              ))
        ],
      ),
    );
  }
}
