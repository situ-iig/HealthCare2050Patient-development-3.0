
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../colors.dart';

phoneAuthButtonStyle(){
  return ElevatedButton.styleFrom(primary: buttonColor,shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8)
  ),fixedSize: Size(100.w, 6.h),elevation: 10);
}