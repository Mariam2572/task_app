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
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * .28,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: MyTheme.primary,
                borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              onTap: () async {
                await provider.changeLanguage('ar');
                Navigator.pop(context);
              },
              child: provider.appLanguage == 'ar'
                  ? getSelectedItem(AppLocalizations.of(context)!.arabic)
                  : getUnSelectedItem(AppLocalizations.of(context)!.arabic),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: MyTheme.primary,
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                  onTap: () async {
                    await provider.changeLanguage('en');
                    Navigator.pop(context);
                  },
                  child: provider.appLanguage == 'en'
                      ? getSelectedItem(AppLocalizations.of(context)!.english)
                      : getUnSelectedItem(
                          AppLocalizations.of(context)!.english)))
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(text, style: Theme.of(context).textTheme.titleLarge),
      ImageIcon(
        const AssetImage('assets/images/icon_check.png'),
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
