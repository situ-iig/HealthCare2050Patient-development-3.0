import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/active_appointments/active_appointment_model.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/helpers/date_and_time_converter.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/utils/styles/text_style.dart';
import 'package:healthcare2050/view/pages/active_booking/active_slot_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/sizes/app_sizes.dart';

class AvailableAppointmentsWidgets {
  BuildContext context;

  AvailableAppointmentsWidgets({required this.context});

  Widget appointmentItemView(bool showAddress,
      {required ActiveAppointmentModel data,required String consultType}) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.height,
          _itemHeaderView(data),
          Divider(
            thickness: 1,
          ),
          _doctorDetailsView(data),
          2.height,
          showAddress == true ? _hospitalAddressView(data.address??"") : Container(),
          Divider(
            thickness: 1,
          ),
          Text("Patient Details..."),
          2.height,
          _patientDetailsView(data)
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 5),
    ).onTap(() {
      var days = differenceBetweenTwoDate(
          statDate: DateTime.now(),
          endDate: data.completedScheduleDate?.add(Duration(days: 1)) ?? DateTime.now());
      showModalBottomSheet(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          context: context,
          builder: (co) {
            return AvailableSlotScreen(data: data, consultType: consultType, days: days,);
          });
    });
  }

  _hospitalAddressView(String address) {
    return Row(
      children: [
        Text(
          "Address: ",
          style: AppTextStyles.boldTextStyle(size: 14),
        ),
        Text(
          address,
          style: AppTextStyles.normalTextStyle(),
        )
      ],
    );
  }

  Widget _itemHeaderView(ActiveAppointmentModel data) {
    var days = differenceBetweenTwoDate(
        statDate: DateTime.now(),
        endDate: data.completedScheduleDate?.add(Duration(days: 1)) ?? DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _headerTextView(
            title: "Booking Date",
            value: convertDate(
                yourDate: data.scheduleDate ?? DateTime.now(),
                format: dateFormatWithHalfMonthName),
            valueTextColor: Colors.green),
        _headerTextView(
            title: "Validity",
            value: days != 0 ? "$days days more" : "Today only",
            valueTextColor: Colors.red),
      ],
    );
  }

  Widget _headerTextView(
      {required String title,
      required String value,
      required Color valueTextColor}) {
    return Row(
      children: [
        Text("$title: ",style: AppTextStyles.normalTextStyle(),),
        Text(
          value,
          style: AppTextStyles.normalTextStyle(txtColor: valueTextColor),
        )
      ],
    );
  }

  Widget _doctorDetailsView(ActiveAppointmentModel data) {
    var image =
        "$doctorImagePath${data.image}";
    var height = screenHeight(context);
    var width = screenWidth(context);
    return Row(
      children: [
        showNetworkImageWithCached(
            imageUrl: image, height: height / 7, width: width / 4, radius: 5),
        SizedBox(
          width: width / 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.doctorName ?? "Not Found",
                style: AppTextStyles.boldTextStyle(),
                maxLines: 2,
              ),
              Text(
                data.qualification ?? "Not Found",
                style: AppTextStyles.normalTextStyle(size: 14),
                maxLines: 2,
              ),
              Text(
                data.specializationName ?? "Not Found",
                style: AppTextStyles.normalTextStyle(size: 12),
                maxLines: 2,
              ),
            ],
          ).paddingSymmetric(horizontal: 10),
        )
      ],
    );
  }

  Widget _patientDetailsView(ActiveAppointmentModel data) {
    return Row(
      children: [
        Flexible(
          child: Text(
            data.patientName ?? "Not Found",
            style: AppTextStyles.boldTextStyle(size: 14),
            maxLines: 2,
          ),
        ),
        _dotView(),
        Text(
          data.patientGender ?? "Not Found",
          style: AppTextStyles.normalTextStyle(),
          maxLines: 2,
        ),
        _dotView(),
        Text(
          "${data.patientAge} Years",
          style: AppTextStyles.normalTextStyle(),
          maxLines: 2,
        ),
        _dotView(),
        Text(
          "+91 ${data.patientMobileNumber}",
          style: AppTextStyles.normalTextStyle(),
          maxLines: 2,
        )
      ],
    );
  }

  Widget _dotView() {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 2,
    ).paddingAll(4);
  }
}
