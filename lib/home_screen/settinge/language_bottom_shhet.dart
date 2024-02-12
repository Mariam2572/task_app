import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
        var provider =Provider.of<AppConfigProvider>(context);

    return  Container(

      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: MyTheme.primary
              , borderRadius: BorderRadius.circular(20)
            ),
            child: InkWell(
              onTap: () {
                    provider.changeLanguage('ar');
                  },
            child:provider.appLanguage =='ar'? getSelectedItem(AppLocalizations.of(context)!.arabic):
            getUnSelectedItem(AppLocalizations.of(context)!.arabic)
            ),
          ),
          Container(
             margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: MyTheme.primary
              , borderRadius: BorderRadius.circular(20)
            ),
            child: InkWell(
              onTap: () {
                    provider.changeLanguage('en');
                  },
              child: provider.appLanguage == 'en' ?getSelectedItem(AppLocalizations.of(context)!.english)
              :getUnSelectedItem(AppLocalizations.of(context)!.english)
            ))
        ],
      ),
    );
  }

 Widget getSelectedItem(String text) {
    return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text,style: Theme.of(context).textTheme.titleLarge),
                  ImageIcon(
                    
                  AssetImage('assets/images/icon_check.png'),
                  size: 35,
                  color: MyTheme.whiteColor,
                  ),
                  ]
              );
  }
  
 Widget getUnSelectedItem(String text) {
return Row(
                children: [
                  Text(text,
                  style: Theme.of(context).textTheme.titleLarge),
                ],
              );
  }

}