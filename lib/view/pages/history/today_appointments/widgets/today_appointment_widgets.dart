import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/colors.dart';

class TodayAppointmentWidgets {
  static Widget noAppointmentView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sorry, No appointments today",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
          ),
          5.height,
          Text(
            "Book an appointment and consult with our best doctor",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                fontSize: 12),
          ),
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }

  static iconView(IconData icon, {void Function()? onPressed, String? title}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40.w,
        decoration: boxDecorationRoundedWithShadow(8,
            backgroundColor: secondaryBgColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            10.width,
            Text(
              title ?? "",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    );
  }
}
