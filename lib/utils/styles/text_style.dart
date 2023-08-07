import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:readmore/readmore.dart';

import '../sizes/default_sizes.dart';

titleTextStyle(){
  return TextStyle(
    color: titleTextColor,
    fontSize: 20
  );
}
Widget showMoreTextView(String data,{Color moreTextColor = Colors.white,Color textColor = Colors.black,}){
  return ReadMoreText(
    data,
    textDirection: TextDirection.ltr,
    trimLines: 3,
    textAlign: TextAlign.left,
    trimMode: TrimMode.Line,
    trimCollapsedText: " Show More ",
    trimExpandedText: " Show Less ",
    lessStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: moreTextColor,
    ),
    moreStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: moreTextColor,
    ),
    style: TextStyle(fontSize: 14, color: textColor),
  );
}

class AppTextStyles {

  /// normal text style
  static TextStyle normalTextStyle({
    Color? txtColor,
    Color? bgColor,
    double size = normalTextSize,
    FontWeight? fontWeight,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      backgroundColor: bgColor,
      color: txtColor??normalTextColor,
      fontSize: size,
      overflow: overflow,
      fontWeight: FontWeight.normal,);
  }

  /// bold text style
  static TextStyle boldTextStyle({
    Color? txtColor,
    Color? bgColor,
    double size = boldTextSize,
    FontWeight? fontWeight,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      backgroundColor: bgColor,
      color: txtColor??normalTextColor,
      fontSize: size,
      overflow: overflow,
      fontWeight: FontWeight.bold,);
  }

  /// read more text style
  // Widget showMoreTextView(
  //     String data, {
  //       Color moreTextColor = Colors.white,
  //       Color textColor = Colors.black,
  //       TextStyle? textStyle,
  //       TextStyle? moreTextStyle,
  //       TextStyle? lessTextStyle
  //     }) {
  //   return ReadMoreTextBuilder(
  //     data,
  //     textDirection: TextDirection.ltr,
  //     trimLines: 3,
  //     textAlign: TextAlign.left,
  //     trimMode: TrimMode.Line,
  //     trimCollapsedText: " Show More ",
  //     trimExpandedText: " Show Less ",
  //     lessStyle: lessTextStyle??boldTextStyle(),
  //     moreStyle: boldTextStyle(),
  //     style: textStyle??normalTextStyle(),
  //   );
  // }

  static TextStyle appbarTextStyle({Color txtColor = normalTextColor,
    TextOverflow? overflow,})=> TextStyle(color: txtColor,fontWeight: FontWeight.bold,fontSize: appBarTextSize);

  static TextStyle buttonTextStyle({Color txtColor = normalTextColor,
    double textSize = 16,})=> TextStyle(color: txtColor,fontWeight: FontWeight.bold,fontSize: textSize);
}