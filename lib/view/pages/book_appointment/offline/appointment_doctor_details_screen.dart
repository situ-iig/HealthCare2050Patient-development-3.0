import 'dart:async';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/appointments/doctor_appointment_model.dart';
import 'package:healthcare2050/services/appointments/offline_appointment_apis.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/view/pages/book_appointment/offline/offline_patient_details_screen.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/helpers/internet_helper.dart';
import '../../auth/phone_auth_screen.dart';

class AppointmentDoctorDetailsScreen extends StatefulWidget {
  final DoctorAppointmentModel doctorData;
  final String cityId;

  const AppointmentDoctorDetailsScreen(
      {Key? key, required this.doctorData, required this.cityId})
      : super(key: key);

  @override
  State<AppointmentDoctorDetailsScreen> createState() =>
      _AppointmentDoctorDetailsScreenState(doctorData);
}

class _AppointmentDoctorDetailsScreenState
    extends State<AppointmentDoctorDetailsScreen> with WidgetsBindingObserver {
  final DoctorAppointmentModel doctorData;

  _AppointmentDoctorDetailsScreenState(this.doctorData);

  var currentDate = DateTime.now();
  var selectedDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());

  //late Timer timer;

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});

    Provider.of<SlotsAppointmentProvider>(context, listen: false)
        .getAvailableDoctorSlot(selectedDate, doctorData.doctorId.toString(),
            doctorData.specId.toString());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getSlotsData(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Details"),
      ),
      body: Column(
        children: [
          _doctorDetailsViewCard(doctorData),
          _calenderView(doctorData),
          Divider(
            thickness: 1,
            color: iconColor,
          ),
          10.height,
          Expanded(child: _showSlotsView())
        ],
      ),
    );
  }

  getSlotsData(String date) async {
    LoaderDialogView(context).showLoadingDialog();
    Provider.of<SlotsAppointmentProvider>(context, listen: false)
        .getAvailableDoctorSlot(
            date, doctorData.doctorId.toString(), doctorData.specId.toString());
    Future.delayed(Duration(seconds: 1), () {
      LoaderDialogView(context).dismissLoadingDialog();
    });
  }

  Widget _doctorDetailsViewCard(DoctorAppointmentModel data) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * .32,
      width: width,
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Card(
                elevation: 5,
                color: secondaryBgColor,
                child: SizedBox(
                  height: 160,
                  width: width,
                  child: _doctorDetailsView(data),
                ),
              )),
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: 140,
                width: 140,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70),
                      side: BorderSide(width: 2, color: iconColor)),
                  child: showNetworkImageWithCached(
                          imageUrl: "$doctorImagePath${doctorData.image}",
                          height: 140,
                          width: 140,
                          radius: 70)
                      .paddingAll(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _doctorDetailsView(DoctorAppointmentModel data) {
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
        Divider(
          thickness: 1,
          color: Colors.white,
        ),
        Text(
          data.address ?? "Address Not Found",
          style: secondaryTextStyle(color: Colors.white, size: 12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ).paddingSymmetric(horizontal: 10),
        10.height
      ],
    );
  }

  _calenderView(DoctorAppointmentModel data) {
    return CalendarTimeline(
      showYears: false,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
      onDateSelected: (date) {
        var selectedDate = new DateFormat('yyyy-MM-dd').format(date);
        setState(() => currentDate = date);
        getSlotsData(selectedDate);
      },
      leftMargin: 20,
      monthColor: textColor,
      dayColor: textColor,
      dayNameColor: Colors.white,
      activeDayColor: Colors.white,
      activeBackgroundDayColor: textColor,
      dotsColor: Colors.white,
      //selectableDayPredicate: (date) => date.day != 23,
      locale: 'en',
    );
  }

  _showSlotsView() {
    return Consumer<SlotsAppointmentProvider>(
      builder: (BuildContext context, value, Widget? child) {
        var slotList = value.allSlots;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: slotList.isNotEmpty
              ? GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      mainAxisExtent: 100,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: slotList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return OutlinedButton.icon(
                      icon: Icon(
                        Icons.lock_clock,
                        color: themColor,
                      ),
                      label: Text(
                        "${slotList[index].startTime.toString()}" +
                            "-" +
                            "${slotList[index].endTime.toString()}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      onPressed: () async {
                        if (await getBoolFromLocal(loggedInKey) == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OfflinePatientDetailsScreen(
                                  currentDate: currentDate,
                                  doctorData: doctorData,
                                  cityId: widget.cityId,
                                  slotId: slotList[index]
                                      .doctorAvailableId
                                      .toString(),
                                  slotTiming:
                                      "${slotList[index].startTime} - ${slotList[index].endTime}",
                                  slotDate: DateFormat("dd MMM yyyy")
                                      .format(currentDate),
                                  amount: value.payableAmount,
                                ),
                                fullscreenDialog: true,
                              ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                    title: Column(
                                      children: [
                                        Text("Not Registered User"),
                                        Icon(
                                          Icons.person,
                                          color: themColor,
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                        "Please Login to get the facilities"),
                                    actions: [
                                      CupertinoDialogAction(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                      CupertinoDialogAction(
                                          child: Text("Login"),
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PhoneAuthScreen()),
                                                (route) => false);
                                          }),
                                    ],
                                  ));
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: themColor),
                      ),
                    );
                  })
              : Text("Slot Not Available",
                  style: boldTextStyle(color: textColor)),
        );
      },
    );
  }
}
