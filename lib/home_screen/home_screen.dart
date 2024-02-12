import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_app/home_screen/list_task/add_task_bottom_sheet.dart';
import 'package:task_app/home_screen/list_task/list_tab.dart';
import 'package:task_app/home_screen/settinge/settings_tab.dart';
import 'package:task_app/providers/app_config_provider.dart';
import 'package:task_app/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
static const String routeName ='Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedIndex= 0;
List<Widget> tabs =[TaskList(), SettingsTab()];
  @override
  Widget build(BuildContext context) {
   var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      body: selectedIndex == 0 ? TaskList() 
      :
      SettingsTab() ,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.18,
        title: Text( AppLocalizations.of(context)!.app_title  ,
        style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color:provider.isDark()?MyTheme.blackDark:MyTheme.whiteColor ,
        shape: CircularNotchedRectangle(),
        
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex =index;
            setState(() {
              
            });
          },
          items: [
          BottomNavigationBarItem(
          
            icon: ImageIcon(AssetImage('assets/images/icon_list.png')) ,label: AppLocalizations.of(context)!.list),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/icon_settings.png')) ,label: AppLocalizations.of(context)!.settings)
        ]),
      ),
    floatingActionButton: FloatingActionButton(onPressed: (){
      showAddTaskBottomSheet();
    }, 
    child: Icon(Icons.add, size: 35,),
    
    ),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  
  void showAddTaskBottomSheet() {
    showModalBottomSheet(context: context,
    builder: (context) => AddTaskBottomSheet(),
     );
  }
}