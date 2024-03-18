import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_app/auth/login/login.dart';
import 'package:task_app/home/list_task/add_task_bottom_sheet.dart';
import 'package:task_app/home/list_task/list_tab.dart';
import 'package:task_app/home/settings/settings_tab.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/providers/auth_provider.dart';
import 'package:task_app/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [TaskList(), SettingsTab()];
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProviders>(context);

    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      body: selectedIndex == 0 ? TaskList() : SettingsTab(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              if (provider.tasksList.isEmpty) {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              } else {
                provider.tasksList = [];
                authProvider.currentUser = null;
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              }
            },
            icon: Icon(Icons.logout),
          )
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        title: Text(
          selectedIndex == 0
              ? '${AppLocalizations.of(context)?.app_title}\n ${authProvider.currentUser!.name!}'
              : '${AppLocalizations.of(context)?.settings}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: provider.isDark() ? MyTheme.blackDark : MyTheme.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                      AssetImage('assets/images/icon_list.png')),
                  label: AppLocalizations.of(context)?.list),
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                      AssetImage('assets/images/icon_settings.png')),
                  label: AppLocalizations.of(context)?.settings)
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AddTaskBottomSheet(),
      ),
    );
  }
}
