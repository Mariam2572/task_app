import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: MyTheme.primary,
                borderRadius: BorderRadius.circular(20)),
            child: InkWell(
                onTap: () {
                  provider.changeTheme(ThemeMode.light);
                },
                child: provider.isDark()
                    ? getUnSelectedItem(AppLocalizations.of(context)!.light_mode)
                    : getSelectedItem(AppLocalizations.of(context)!.light_mode)),
          ),
          Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: MyTheme.primary,
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                  onTap: () {
                    provider.changeTheme(ThemeMode.dark);
                  },
                  child: provider.isDark()
                      ? getSelectedItem(AppLocalizations.of(context)!.dark_mode)
                      : getUnSelectedItem(
                          AppLocalizations.of(context)!.dark_mode)))
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(text, style: Theme.of(context).textTheme.titleLarge),
      ImageIcon(
        AssetImage('assets/images/icon_check.png'),
        size: 35,
        color: MyTheme.whiteColor,
      ),
    ]);
  }

  Widget getUnSelectedItem(String text) {
    return Row(
      children: [
        Text(text, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
