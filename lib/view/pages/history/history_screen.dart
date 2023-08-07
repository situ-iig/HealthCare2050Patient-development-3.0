import 'package:flutter/material.dart';
import 'package:healthcare2050/Providers/history_appointment_provider.dart';
import 'package:healthcare2050/services/consultations/consultation_prescription_apis.dart';
import 'package:healthcare2050/view/pages/consultations/prescription_pdf_view.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/history/appointment_history_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/helpers/internet_helper.dart';

class HistoryScreen extends StatefulWidget {
  final String consultType;

  const HistoryScreen({Key? key, required this.consultType}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: HistoryAppointmentProvider()
            .getHistoryAppointments(widget.consultType),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<HistoryScheduleData> data = snapshot.data;
            return data.isNotEmpty ? gridListView(data) : _noAppointmentView();
          } else if (snapshot.hasError) {
            return ErrorScreen();
          } else {
            return ScreenLoadingView();
          }
        },
      ),
    );
  }

  Widget gridListView(List<HistoryScheduleData> data) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Container(
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
                            child: Text(
                                data[index].sepcializationName ?? "",
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
                            5.width,
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
                                5.width,
                                Text(
                                    data[index].patientAge.toString() +
                                        " yrs",
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
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              size: 15,
                            ),
                            5.width,
                            Text("${data[index].scheduleDate}")
                          ],
                        ),
                        10.height,
                        _showConsultIcons(
                            data[index].consultationType ?? 4,
                            data[index].status.toString(),
                            data[index].id.toString()),
                        10.height,
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

  Widget _showConsultIcons(int type, String status, String id) {
    if (type == 1 && status == "3") {
      return _iconView(Icons.video_call_outlined,secondaryBgColor,'View Prescription', onPressed: () {
        LoaderDialogView(context).showLoadingDialog();
        getPrescriptionPdf(id).then((value) async {
          LoaderDialogView(context).dismissLoadingDialog();
          if (value['status'] == true) {
            PrescriptionPdfView(
              document: value['url'],
            ).launch(context);
          } else {
            Fluttertoast.showToast(msg: "Something went wrong");
          }
        });
      });
    } else if (type == 2 && status == "3") {
      return _iconView(Icons.call, secondaryBgColor,'View Prescription',onPressed: () {});
    } else {
      return _iconView(Icons.call, Colors.grey,'Prescription Unavailable',onPressed: () {});
    }
  }

  _iconView(IconData icon,Color bgColor,String title, {void Function()? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 100.w,
        decoration: boxDecorationRoundedWithShadow(8,
            backgroundColor: bgColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            5.width,
            Icon(
              Icons.contact_page_outlined,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _noAppointmentView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Still Haven't any appointment",
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
}
