
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';


Image notConnectionImageView(){
  return Image.asset("assets/images/no_internet_img.png",height: 35.h,width: 80.w,fit: BoxFit.cover,);
}

Widget internetMessage(){
  return Text("Currently you are not connected to internet. Please check internet connection and try again.",textAlign: TextAlign.center,).paddingSymmetric(horizontal: 16);
}

Text topTitleNoInternet(){
  return Text("Internet Not Available",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),);
}

Widget tryAgainButton(){
  var radius = BorderRadius.circular(20);
  return Container(
    height: 6.h,
    margin: EdgeInsets.symmetric(horizontal: 16,),
    //width: 20.w,
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius:radius),
      child: Center(child: Text("Try Again").paddingSymmetric(horizontal: 10)),
    ),
  );
}
