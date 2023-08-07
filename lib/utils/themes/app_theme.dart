import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:sizer/sizer.dart';

import '../styles/text_style.dart';

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(

      // style: ElevatedButton.styleFrom(primary: appButtonColor,));

      style: ElevatedButton.styleFrom(
    primary: buttonColor,
    minimumSize: Size.fromHeight(6.h),
  ));
}

ThemeData appTheme() => ThemeData(
    backgroundColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: appBarTheme(),
    //checkboxTheme: checkboxTheme(),
    iconTheme: appIconTheme(),
    listTileTheme: listTileTheme(),
    primaryIconTheme: appIconTheme(),
    //dialogTheme: appAlertTheme(),
    //elevatedButtonTheme: elevatedButtonTheme(),
    //inputDecorationTheme: appInputDecorationTheme(),
    floatingActionButtonTheme: floatingTheme());

ListTileThemeData listTileTheme() => ListTileThemeData(
      tileColor: secondaryBgColor,
      textColor: blackColor,
      iconColor: whiteColor,
    );

FloatingActionButtonThemeData floatingTheme() => FloatingActionButtonThemeData(
      backgroundColor: floatingActionButtonColor,
    );

CheckboxThemeData checkboxTheme() => CheckboxThemeData();

AppBarTheme appBarTheme() => AppBarTheme(
    backgroundColor: appBarColor,
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: titleTextStyle(),
    elevation: 5,
    centerTitle: false,
    toolbarTextStyle: titleTextStyle());

IconThemeData appIconTheme() => IconThemeData(
      color: iconColor,
      size: 20,
    );

// DialogTheme appAlertTheme() => DialogTheme(
//     backgroundColor: whiteColor,
//     titleTextStyle: boldText(),
//     contentTextStyle: smallTextStyle(),
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(4))));
