import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:healthcare2050/view/pages/book_appointment/online/online_consultation_booking_screen.dart';
import 'package:healthcare2050/view/widgets/app_shimmer_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Model/appointments/online/online_doctor_model.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/styles/image_style.dart';

doctorCardView(
    OnlineDoctorsModel data, BuildContext context, String specializationId) {
  var height = screenHeight(context);
  var width = screenWidth(context);
  return SizedBox(
    height: height/4,
    width: width,
    child: Stack(
      children: [
        Positioned(
            right: 10,
            child: _doctorDetailsView(data, context, specializationId)),
        Positioned(
            top: 30,
            left: 20,
            bottom: 30,
            child: _doctorImageView(data.image ?? "")),
      ],
    ),
  );
}

_doctorImageView(String image) {
  var imagePath = "$doctorImagePath$image";
  return showNetworkImageWithCached(
      imageUrl: imagePath, height: 100, width: 110, radius: 12);
}

_doctorDetailsView(
    OnlineDoctorsModel data, BuildContext context, String specializationId) {
  var doctorData = OnlineDoctorsModel(
      designation: data.designation,
      education: data.education,
      fullName: data.fullName,
      id: data.id,
      image: data.image,
      sepcializationName: data.designation,
      teleConsult: data.teleConsult,
      videoConsult: data.videoConsult);
  var height = screenHeight(context);
  var width = screenWidth(context);
  return InkWell(
    onTap: () {
      _showBottomSheet(context, data, specializationId);
    },
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: secondaryBgColor,
      child: SizedBox(
        height: height/4.2,
        width: width/1.3,
        child: Column(
          children: [
            10.height,
            Text(
              data.fullName ?? "Not Found",
              style: boldTextStyle(color: Colors.white, size: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              data.education ?? "Education not found",
              style: secondaryTextStyle(color: Colors.white, size: 14),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            2.height,
            Text(
              data.designation ?? "No Designation",
              style: secondaryTextStyle(color: Colors.white, size: 12),
              textAlign: TextAlign.center,
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                data.teleConsult == 1
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OnlineConsultationBookingScreen(
                                        doctorsModel: doctorData,
                                        specializationId: specializationId,
                                        consultType: "2",
                                      )));
                        },
                        child: _iconView(CupertinoIcons.phone, Colors.green),
                      )
                    : _iconView(CupertinoIcons.phone, Colors.grey),
                30.width,
                data.videoConsult == 1
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OnlineConsultationBookingScreen(
                                        doctorsModel: doctorData,
                                        specializationId: specializationId,
                                        consultType: "1",
                                      )));
                        },
                        child:_iconView(Icons.video_call, Colors.green)

                      ):_iconView(Icons.video_call_outlined, Colors.grey)

              ],
            )
          ],
        ).paddingOnly(left: 60, top: 10, bottom: 10, right: 10),
      ),
    ),
  );
}

_iconView(IconData icon,Color bgColor){
  return CircleAvatar(
    radius: 25,
    child: Icon(
      icon,
      color: Colors.white,
    ),
    backgroundColor: bgColor,
  );
}

_showBottomSheet(
    BuildContext context, OnlineDoctorsModel data, String specializationId) {
  var doctorData = OnlineDoctorsModel(
      designation: data.designation,
      education: data.education,
      fullName: data.fullName,
      id: data.id,
      image: data.image,
      sepcializationName: data.designation,
      teleConsult: data.teleConsult,
      videoConsult: data.videoConsult);
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      backgroundColor: Colors.white,
      builder: (context) => showConsultationTypeBottomSheet(
          context, doctorData, specializationId));
}

Widget noDoctorAvailableView() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sorry, No doctor available",
          style: boldTextStyle(color: textColor, size: 20),
        ),
        Text(
          "Doctor will be available very soon",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    ).paddingSymmetric(horizontal: 10),
  );
}

showConsultationTypeBottomSheet(BuildContext context,
    OnlineDoctorsModel doctorsModel, String specializationId) {
  return Container(
    height: 250,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      children: [
        20.height,
        Text(
          "Consultation Type",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        20.height,
        doctorsModel.teleConsult == 1
            ? ListTile(
                onTap: () {
                  finish(context);
                  OnlineConsultationBookingScreen(
                    doctorsModel: doctorsModel,
                    specializationId: specializationId.toString(),
                    consultType: "2",
                  ).launch(context,
                      pageRouteAnimation: PageRouteAnimation.Slide,
                      duration: Duration(seconds: 1));
                },
                tileColor: Colors.white,
                title: Text("Telephone Consultation"),
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
              )
            : _notAvailableTileView(
                context, "Telephone Consultation", Icons.call),
        Divider(
          thickness: 1,
          color: iconColor,
        ),
        doctorsModel.videoConsult == 1
            ? ListTile(
                onTap: () {
                  finish(context);
                  OnlineConsultationBookingScreen(
                    doctorsModel: doctorsModel,
                    specializationId: specializationId.toString(),
                    consultType: "1",
                  ).launch(context,
                      pageRouteAnimation: PageRouteAnimation.Slide,
                      duration: Duration(seconds: 1));
                },
                tileColor: Colors.white,
                title: Text("Video Consultation"),
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.video_call,
                    color: Colors.white,
                  ),
                ),
              )
            : _notAvailableTileView(
                context, "Video Consultation", Icons.video_call),
        doctorsModel.videoConsult == 1
            ? Divider(
                thickness: 1,
                color: iconColor,
              )
            : Container(),
      ],
    ),
  );
}

_notAvailableTileView(BuildContext context, String title, IconData icon) {
  return ListTile(
    onTap: () {
      Fluttertoast.showToast(
          msg: "Sorry, $title not available to this doctor.");
    },
    tileColor: Colors.white,
    title: Text(title),
    leading: CircleAvatar(
      backgroundColor: Colors.grey,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}

shimmerDoctorCardView(BuildContext context) {
  return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 25.h,
          width: 100.w,
          child: Stack(
            children: [
              Positioned(right: 10, child: _shimmerDoctorDetailsView()),
              Positioned(
                  top: 30,
                  left: 20,
                  bottom: 30,
                  child: _shimmerDoctorImageView()),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return 10.height;
      },
      itemCount: 10);
}

_shimmerDoctorImageView() {
  return appShimmerView(100, 110, radius: 12);
}

_shimmerDoctorDetailsView() {
  return appShimmerView(
    25.h,
    75.w,
  );
}
