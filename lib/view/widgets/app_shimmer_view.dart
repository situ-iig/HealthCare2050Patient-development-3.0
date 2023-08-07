import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';


 Widget appShimmerView(double? height,double? width, {double radius = 4.0,Widget? child,double elevation = 0}){
  return Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(.5),
    highlightColor: Colors.white,
    child: SizedBox(
      height: height,
      width: width,
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)
        ),
        child: child,
      ),
    ),
  );
}

Widget appTextShimmerView({Widget? child}){
   return Shimmer.fromColors(
     baseColor: Colors.grey.withOpacity(.5),
     highlightColor: Colors.white,
     child: child??SizedBox(),
   );
}
