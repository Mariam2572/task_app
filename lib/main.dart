import 'package:flutter/material.dart';
import 'package:task_app/home_screen/home_screen.dart';

void main(){
  runApp(ToDoApp());
}class ToDoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName :(context) => HomeScreen(),
      },
    );
  }
}