import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/Doctor/doctor_details_model.dart';
import '../../../../Model/appointments/online/online_doctor_model.dart';
import '../../book_appointment/online/online_consultation_booking_screen.dart';
import '../../book_appointment/online/widgets/online_doctor_widgets.dart';

class DoctorWidgets{
  doctorCardView(DoctorDetailsModel data,BuildContext context){
    return SizedBox(
      height: 25.h,
      width: 100.w,
      child: Stack(
        children: [
          Positioned(
            right: 10,
              child: _doctorDetailsView(data,context)),
          Positioned(
            top: 30,
              left: 20,
              bottom: 30,
              child: _doctorImageView(data.image??"")),
        ],
      ),
    );
  }
  _doctorImageView(String image){
    var imagePath = "$doctorImagePath$image";
    return showNetworkImageWithCached(imageUrl: imagePath, height: 100, width: 110, radius: 12);
  }

  _doctorDetailsView(DoctorDetailsModel data,BuildContext context){
    var doctorData = OnlineDoctorsModel(
        designation: data.designation,
        education: data.education,
        fullName: data.fullName,
        id: data.id,
        image: data.image,
        sepcializationName: data.designation,
        teleConsult: data.teleConsult,
        videoConsult: data.videoConsult
    );
    return InkWell(
      onTap: (){
        _showBottomSheet(context, data);
      },
      child: SizedBox(
        height: 25.h,
        width: 75.w,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          color: secondaryBgColor,
          child: Column(
            children: [
              10.height,
              Text(data.fullName??"Not Found",style: boldTextStyle(color: Colors.white,size: 16),),
              Text(data.education??"Education not found",style: secondaryTextStyle(color: Colors.white,size: 14),textAlign: TextAlign.center,),
              2.height,
              Text(data.designation??"No Designation",style: secondaryTextStyle(color: Colors.white,size: 12),textAlign: TextAlign.center,),
              30.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                 data.teleConsult == 1? InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnlineConsultationBookingScreen(
                                doctorsModel: doctorData,
                                specializationId: data.specializationId.toString(),
                                consultType: "2",
                              )));
                    },
                    child: CircleAvatar(
                      radius: 25,
                      child: Icon(CupertinoIcons.phone,color: Colors.white,),
                      backgroundColor: Colors.green,
                    ),
                  ):CircleAvatar(
                   radius: 25,
                   child: Icon(CupertinoIcons.phone,color: Colors.white,),
                   backgroundColor: Colors.grey,
                 ),
                  30.width,
                  data.videoConsult == 1?InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnlineConsultationBookingScreen(
                                doctorsModel: doctorData,
                                specializationId: data.specializationId.toString(),
                                consultType: "1",
                              )));
                    },
                    child: CircleAvatar(
                      radius: 25,
                      child: Icon(CupertinoIcons.video_camera,color: Colors.white,),
                      backgroundColor: Colors.green,
                    ),
                  ):CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.video_call_outlined,color: Colors.white,),
                    backgroundColor: Colors.grey,
                  )
                ],
              )
            ],
          ).paddingOnly(left: 60,top: 10,bottom: 10,right: 10),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context,DoctorDetailsModel data){
    var doctorData = OnlineDoctorsModel(
      designation: data.designation,
      education: data.education,
      fullName: data.fullName,
      id: data.id,
      image: data.image,
      sepcializationName: data.designation,
      teleConsult: data.teleConsult,
      videoConsult: data.videoConsult
    );
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: Colors.white,
        builder: (context) => showConsultationTypeBottomSheet(
            context, doctorData, data.specializationId.toString()));
  }
}