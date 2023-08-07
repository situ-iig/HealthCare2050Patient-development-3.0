
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/basic_strings.dart';
Widget splashImageView(){
  return Image.asset('assets/Logo/logo_gif.gif',height: 15.h,
    width: 30.w,).paddingAll(20);
}

Widget splashLogoDecoration(Widget child){
  return SizedBox(
    height: 140,
    width: 140,
    child: Card(
      elevation: 10,
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(70)
      ),
    ),
  );
}

Text splashTitle(){
  return Text(appName,textAlign:TextAlign.center,style: secondaryTextStyle(color: Colors.white,size: 12,),);
}

Widget splashMessage(){
  return Center(child: Text(splashMessageText,style: boldTextStyle(color: Colors.yellow,size: 20,),textAlign: TextAlign.center,));
}