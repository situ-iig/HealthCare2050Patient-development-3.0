import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/appointments/online/online_doctor_model.dart';
import 'package:healthcare2050/services/appointments/online_appointment_apis.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/view/pages/book_appointment/online/widgets/online_consultation_booking_widgets.dart';
import 'package:healthcare2050/view/pages/book_appointment/online/widgets/online_consultation_form_view.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/data/local_data_keys.dart';
import '../../../../utils/helpers/internet_helper.dart';
import '../../../widgets/loader_dialog_view.dart';

class OnlineConsultationBookingScreen extends StatefulWidget {
  final String specializationId;
  final OnlineDoctorsModel doctorsModel;
  final String consultType;

  const OnlineConsultationBookingScreen(
      {Key? key,
      required this.specializationId,
      required this.doctorsModel,
      required this.consultType})
      : super(key: key);

  @override
  State<OnlineConsultationBookingScreen> createState() =>
      _OnlineConsultationBookingScreenState();
}

class _OnlineConsultationBookingScreenState
    extends State<OnlineConsultationBookingScreen> {
  DateTime currentDate = DateTime.now();
  var selectedDate = new DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (s) {});
    Provider.of<OnlineAvailableSlotProvider>(context, listen: false)
        .getOnlineSlots(selectedDate, widget.doctorsModel.id.toString(),
            widget.consultType);
  }


  getAvailableSlot(String date) {
    LoaderDialogView(context).showLoadingDialog();
    Provider.of<OnlineAvailableSlotProvider>(context, listen: false)
        .getOnlineSlots(
            date, widget.doctorsModel.id.toString(), widget.consultType);
    Future.delayed(Duration(seconds: 1), () {
      LoaderDialogView(context).dismissLoadingDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Consultation'),
      ),
      body: Column(
        children: [
          _doctorDetailsViewCard(),
          _calenderView(),
          Divider(
            thickness: 1,
            color: iconColor,
          ),
          Expanded(child: _showSlotsView())
        ],
      ),
    );
  }

  Widget _doctorDetailsViewCard() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height/3.4,
      width: width,
      child: onlineBookingDoctorDetails(context, widget.doctorsModel),
    );
  }

  _calenderView() {
    return CalendarTimeline(
      showYears: false,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
      onDateSelected: (date) {
        var selectedDate = new DateFormat('yyyy-MM-dd').format(date);
        setState(() => currentDate = date);
        getAvailableSlot(selectedDate);
      },
      leftMargin: 20,
      monthColor: textColor,
      dayColor: textColor,
      dayNameColor: Colors.white,
      activeDayColor: Colors.white,
      activeBackgroundDayColor: textColor,
      dotsColor: Colors.white,
      locale: 'en',
    );
  }

  _showSlotsView() {
    return Consumer<OnlineAvailableSlotProvider>(
      builder: (BuildContext context, value, Widget? child) {
        var slotList = value.slotList;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: slotList.isNotEmpty
              ? GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      // mainAxisExtent: 100,
                      childAspectRatio: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: slotList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () async {
                        if (await getBoolFromLocal(loggedInKey) == true) {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> OnlineConsultationFormView(
                            consultType: widget.consultType,
                            speId: widget
                                .specializationId
                                .toString(),
                            date: DateFormat('yyyy-MM-dd')
                                .format(currentDate),
                            slotId: slotList[index]
                                .doctorAvailableId
                                .toString(),
                            doctorsModel: widget.doctorsModel, slotTiming: "${slotList[index].startTime} - ${slotList[index].endTime}", slotDate: DateFormat("dd MMM yyyy").format(currentDate),
                          ),fullscreenDialog: true));

                        } else {
                          Fluttertoast.showToast(msg: "You are not logged in");
                        }
                      },
                      child: onlineSlotItemView(
                          "${slotList[index].startTime} - ${slotList[index].endTime}",
                          context),
                    );
                  })
              : Text("Slot Not Available",
                  style: boldTextStyle(color: textColor)),
        );
      },
    );
  }
}
