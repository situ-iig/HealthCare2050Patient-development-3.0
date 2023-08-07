import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/appointments/online/online_doctor_model.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/styles/image_style.dart';

Widget onlineBookingDoctorDetails(
    BuildContext context, OnlineDoctorsModel doctorData) {
  double width = MediaQuery.of(context).size.width;
  var height = screenHeight(context);
  return Stack(
    children: [
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Card(
            elevation: 5,
            color: secondaryBgColor,
            child: SizedBox(
              height:height/6,
              width: width,
              child: _doctorDetailsView(doctorData),
            ),
          )),
      Positioned(
        top: 10,
        left: 0,
        right: 0,
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(70),
                side: BorderSide(width: 2, color: iconColor)),
            child: showNetworkImageWithCached(
                    imageUrl:
                        "$doctorImagePath${doctorData.image}",
                    height: height/6,
                    width: width/2.8,
                    radius: 70)
                .paddingAll(3),
          ),
        ),
      ),
    ],
  );
}

_doctorDetailsView(OnlineDoctorsModel data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        data.fullName ?? "",
        style: boldTextStyle(color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        data.education ?? "",
        style: secondaryTextStyle(color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        data.designation ?? "",
        style: secondaryTextStyle(color: Colors.white, size: 12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      20.height
    ],
  );
}

Widget onlineSlotItemView(String title, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: textColor,width: 1)
    ),
    child: Row(
      children: [
        Icon(
          Icons.lock_clock,
          color: iconColor,
        ),
        Flexible(
          child: Text(title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 14)),
        )
      ],
    ),
  );
}

