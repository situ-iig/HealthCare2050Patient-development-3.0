import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/history/today_appointment_model.dart';
import 'package:healthcare2050/Providers/history_appointment_provider.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/view/pages/history/today_appointments/widgets/today_appointment_widgets.dart';

import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../../services/consultations/consultation_prescription_apis.dart';
import '../../../../utils/helpers/internet_helper.dart';
import '../../consultations/widgets/agora_client.dart';
import '../../consultations/prescription_pdf_view.dart';
import '../../video_call/patient_video_call_screen.dart';
import '../../voice_call/audio_call_screen.dart';

class TodayAppointmentScreen extends StatefulWidget {
  final String consultType;

  const TodayAppointmentScreen({Key? key, required this.consultType})
      : super(key: key);

  @override
  State<TodayAppointmentScreen> createState() => _TodayAppointmentScreenState();
}

class _TodayAppointmentScreenState extends State<TodayAppointmentScreen> {
  @override
  void initState() {
    super.initState();
    getAppointments();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  Future<void> getAppointments() async {
    Provider.of<HistoryAppointmentProvider>(context, listen: false)
        .getTodayAppointments(widget.consultType);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<HistoryAppointmentProvider>(context, listen: false);
    return Scaffold(
      body: RefreshIndicator(
        color: iconColor,
        onRefresh: () {
          return provider.getTodayAppointments(widget.consultType);
        },
        child: mainView(),
      ),
    );
  }

  mainView() {
    return Consumer<HistoryAppointmentProvider>(builder: (a, data, b) {
      return data.loader == true
          ? ScreenLoadingView()
          : data.todayAppointments.isNotEmpty
              ? gridListView(data.todayAppointments)
              : TodayAppointmentWidgets.noAppointmentView();
    });
  }

  Widget gridListView(List<TodayVideoConsultModel> data) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1.9,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: width,
                          height: height * 0.03,
                          color: secondaryBgColor,
                          child: Center(
                            child: Text(data[index].sepcializationName ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white)),
                          ))),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data[index].doctorName ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: iconColor,
                              size: 15,
                            ),
                            4.width,
                            Text(
                              data[index].patientName ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: iconColor,
                                  size: 15,
                                ),
                                4.width,
                                Text(data[index].patientAge.toString() + " yrs",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: iconColor,
                                  size: 15,
                                ),
                                5.width,
                                Text(
                                  data[index].mobileNumber.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock_clock,
                                    color: iconColor,
                                    size: 15,
                                  ),
                                  5.width,
                                  Text(
                                    "Start Time",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock_clock,
                                    color: iconColor,
                                    size: 15,
                                  ),
                                  5.width,
                                  Text(
                                    "End Time",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data[index].startTime ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(data[index].endTime ?? "",
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        5.height,
                        Align(
                          alignment: Alignment.centerRight,
                          child: _showConsultIcons(data[index]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _showConsultIcons(TodayVideoConsultModel data) {
    var type = data.consultationType;
    String? channelName = data.channelName;
    String? scheduleId = data.id.toString();
    String? status = data.status.toString();
    String? address = data.address;
    String? patientName = data.patientName;
    if (type == 1 && status == "1") {
      return TodayAppointmentWidgets.iconView(Icons.video_call_outlined,
          onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PatientVideoCallScreen(
                      client: handleAgoraClient(
                          channelName ?? "",
                          patientName ?? "Not Available",
                          context,
                          data.doctorId.toString()),
                      // scheduleId: scheduleId,
                    )));
        Fluttertoast.showToast(msg: "Video Call");
      }, title: "Start Video");
    } else if (type == 1 && status == "0") {
      return TodayAppointmentWidgets.iconView(Icons.video_call_outlined,
          onPressed: () {
        _showNotTimeAllowDialog();
      }, title: "Join Call");
    } else if (type == 1 && status == "2") {
      return TodayAppointmentWidgets.iconView(Icons.contact_page_outlined,
          onPressed: () {}, title: "Wait for \nPrescription");
    } else if (type == 1 && status == "3") {
      return TodayAppointmentWidgets.iconView(Icons.contact_page_outlined,
          onPressed: () {
        LoaderDialogView(context).showLoadingDialog();
        getPrescriptionPdf(scheduleId).then((value) async {
          LoaderDialogView(context).dismissLoadingDialog();
          if (value['status'] == true) {
            PrescriptionPdfView(
              document: value['url'],
            ).launch(context);
          } else {
            Fluttertoast.showToast(msg: "Something went wrong");
          }
        });
      }, title: "View \nPrescription");
    } else if (type == 2 && status == "1") {
      return TodayAppointmentWidgets.iconView(Icons.call, onPressed: () {
        AudioCallScreen(
          channelName: data.channelName ?? "",
        ).launch(
          context,
        );
      }, title: "Start Call");
    } else if (type == 2 && status == "0") {
      return TodayAppointmentWidgets.iconView(Icons.call,
          onPressed: () {
            _showNotTimeAllowDialog();
          }, title: " Join Call");
    } else {
      return Row(
        children: [
          Text(
            "Consultation \nAddress : ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              address ?? "Not Available",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }
  }

  _showNotTimeAllowDialog() {
    btnColor(Color bgColor) =>
        ElevatedButton.styleFrom(backgroundColor: bgColor);
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Appointment Time Alert"),
            content:
                Text("Sorry, You can not join call before appointment time."),
            actions: [
              ElevatedButton(
                  style: btnColor(Colors.red),
                  onPressed: () {
                    getAppointments().then((value) {
                      finish(context);
                    });
                  },
                  child: Text("Close")),
              ElevatedButton(
                  style: btnColor(buttonColor),
                  onPressed: () {
                    getAppointments().then((value) {
                      finish(context);
                    });
                  },
                  child: Text("Refresh"))
            ],
          );
        });
  }
}
