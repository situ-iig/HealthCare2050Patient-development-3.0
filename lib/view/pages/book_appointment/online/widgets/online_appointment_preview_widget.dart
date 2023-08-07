
import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/appointments/online/online_doctor_model.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/data/server_data.dart';

class OnlineAppointmentPreviewWidget {

  static Widget doctorDetailsView(OnlineDoctorsModel data) {
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
                    data.fullName ?? "Not Found",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data.education ?? "Not Found",
                    style:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    data.designation ?? "Not Found",
                    style:
                    TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                  ),
                  5.height,
                  Row(
                    children: [
                      Text(
                        "Specialist : ",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        data.sepcializationName ?? "Not Found",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      )
                    ],
                  )
                ],
              )
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 10),
        ],
      ),
    );
  }

  static Widget patientDetailsView(
      String name, String age, String gender, String mobile) {
    return SizedBox(
      width: 100.w,
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
              name,
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              age + " Years, " + gender,
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
                  "+91 " + mobile,
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

  static Widget slotDetailsView(String timing, String date) {
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
          //Text("Address - Ihub, Infocity, Patia, Bhubaneswer, Odisha",style: TextStyle(color: textColor,),)
        ],
      ).paddingAll(8),
    );
  }

  static Widget paymentDetailsView(String amount) {
    var prince = int.parse(amount);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(width: 1, color: Colors.green)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Details",
                style: TextStyle(color: Colors.green),
              ),
              Icon(
                Icons.credit_card,
                color: Colors.green,
              )
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 5),
          Divider(
            color: Colors.green,
            thickness: 1,
            height: 5,
          ),
          Text("Consultation Fee : $currencyRupee $prince").paddingSymmetric(horizontal: 10),
          Text("Consultation fee changes base on city.",style: TextStyle(
            color: Colors.grey,),).paddingSymmetric(horizontal: 10,vertical: 5),
        ],
      ),
    );
  }

}
