import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:healthcare2050/utils/styles/text_style.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../Model/active_appointments/active_appointment_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/data/server_data.dart';
import '../../../../utils/styles/image_style.dart';

class PreviewAppointmentWidgets {
  BuildContext context;
  PreviewAppointmentWidgets({required this.context});

  Widget doctorDetailsView(ActiveAppointmentModel data) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Doctor Details",
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ).paddingAll(10),
          Divider(
            color: textColor,
            thickness: 1,
            height: 1,
          ),
          Row(
            children: [
              showNetworkImageWithCached(
                  imageUrl: "$doctorImagePath${data.image}",
                  height: 100,
                  width: 80,
                  radius: 8),
              10.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data.doctorName ?? "Not Found",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data.qualification ?? "Not Found",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    data.specializationName ?? "Not Found",
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                  ),
                  5.height,
                ],
              )
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 10),
        ],
      ),
    );
  }

  Widget patientDetailsView(
      ActiveAppointmentModel data) {
    var width = screenWidth(context);
    return SizedBox(
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(width: 1, color: iconColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Patient Details",
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            Divider(
              color: textColor,
              thickness: 1,
            ),
            Text(
              data.patientName??"",
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              data.patientAge.toString() + " Years, ${data.patientGender}",
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
            Row(
              children: [
                Text(
                  "Contact : ",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
                Text(
                  "+91 ${data.patientMobileNumber}",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            )
          ],
        ).paddingAll(10),
      ),
    );
  }

  Widget slotDetailsView(String timing, String date) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Slot Details",
            style: TextStyle(color: textColor),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Text(
            "Timing - $timing",
            style:
                TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
          ),
          Text(
            "Date - $date",
            style: TextStyle(
              color: textColor,
            ),
          ),
        ],
      ).paddingAll(8),
    );
  }

  Widget bookingButtonView({void Function()? onSubmit}) {
    return SizedBox(
      height: 60,
      child: Builder(
        builder: (context) {
          final GlobalKey<SlideActionState> _key = GlobalKey();
          return SlideAction(
            innerColor: Colors.white,
            outerColor: Colors.green,
            textStyle: AppTextStyles.boldTextStyle(txtColor: Colors.white),
            text: "Slide To Book Appointment",
            sliderButtonIconSize: 20,
            sliderButtonIconPadding: 5,
            sliderButtonIcon: Icon(
              Icons.arrow_forward,
              color: Colors.green,
            ),
            key: _key,
            onSubmit: onSubmit,
            submittedIcon: Icon(
              Icons.done_outline_outlined,
              color: Colors.white,
            ),
          ).paddingAll(5);
        },
      ),
    );
  }

}
