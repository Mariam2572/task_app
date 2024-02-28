import 'package:flutter/material.dart';

class MyTheme {
  static Color primary = Color(0xff5D9CEC);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color backgroundLight = Color(0xffDFECDB);
  static Color backgroundDark = Color(0xff060E1E);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackLight = Color(0xff383838);
  static Color blackDark = Color(0xff141922);
  static Color greyColor = Color(0xff707070);
  static ThemeData lightMode = ThemeData(
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primary, unselectedItemColor: greyColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primary,
          shape: StadiumBorder(side: BorderSide(color: whiteColor, width: 5))
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(35),
          //   side: BorderSide(color: whiteColor, width: 4)
          // )
          ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 22, color: whiteColor, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: blackLight),
          titleSmall: TextStyle(
              fontWeight: FontWeight.w400,
               fontSize: 14,
                color: greyColor)),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ));
  static ThemeData darkMode = ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: primary
      
    ),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(unselectedItemColor: MyTheme.whiteColor),
      scaffoldBackgroundColor: backgroundDark,
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 22, color: blackDark, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
          titleSmall: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 18, color: whiteColor)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primary,
          shape: StadiumBorder(side: BorderSide(color: blackDark, width: 5))),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: blackDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )));
}
