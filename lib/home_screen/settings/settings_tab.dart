import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:task_app/home_screen/settings/language_bottom_shhet.dart';
import 'package:task_app/home_screen/settings/theme_bottom_sheet.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: provider.isDark()
                      ? MyTheme.whiteColor
                      : MyTheme.blackLight)),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: provider.isDark() ? MyTheme.blackDark : MyTheme.whiteColor,
              border: Border.all(color: MyTheme.primary)),
          child: InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.language,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: provider.isDark()
                            ? MyTheme.primary
                            : MyTheme.blackLight)),
                Icon(
                  Icons.arrow_drop_down,
                  size: 35,
                  color: MyTheme.primary,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: provider.isDark()
                      ? MyTheme.whiteColor
                      : MyTheme.blackLight)),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: provider.isDark() ? MyTheme.blackDark : MyTheme.whiteColor,
              border: Border.all(color: MyTheme.primary)),
          child: InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.mode,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: provider.isDark()
                            ? MyTheme.primary
                            : MyTheme.blackLight)),
                Icon(
                  Icons.arrow_drop_down,
                  size: 35,
                  color: MyTheme.primary,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: MyTheme.primary)),
      builder: (context) {
        return LanguageBottomSheet();
      },
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: MyTheme.primary)),
      builder: (context) {
        return ThemeBottomSheet();
      },
    );
  }
}
