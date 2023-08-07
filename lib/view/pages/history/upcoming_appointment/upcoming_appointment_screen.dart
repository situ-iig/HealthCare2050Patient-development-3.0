import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/history/upcomming_appointment_model.dart';
import 'package:healthcare2050/utils/helpers/date_and_time_converter.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/history_appointment_provider.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/helpers/internet_helper.dart';

class UpcomingAppointmentScreen extends StatefulWidget {
  final String consultType;

  const UpcomingAppointmentScreen({Key? key, required this.consultType})
      : super(key: key);

  @override
  State<UpcomingAppointmentScreen> createState() =>
      _UpcomingAppointmentScreenState();
}

class _UpcomingAppointmentScreenState extends State<UpcomingAppointmentScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HistoryAppointmentProvider>(context, listen: false)
        .getUpcomingAppointments(widget.consultType);
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          color: iconColor,
          onRefresh: () {
            return HistoryAppointmentProvider()
                .getUpcomingAppointments(widget.consultType);
          },
          child: mainView()),
    );
  }

  mainView() {
    return Consumer<HistoryAppointmentProvider>(builder: (a, data, b) {
      return data.loader == true
          ? ScreenLoadingView()
          : data.upcomingAppointment.isNotEmpty
              ? gridListView(data.upcomingAppointment)
              : _noAppointmentView();
    });
  }

  Widget gridListView(List<UpcomingScheduleModel> data) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.5,
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
                                Text(
                                    data[index].patientAge.toString() +
                                        "yrs",
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
                            Text("Date : "),
                            Text(convertDate(yourDate: data[index].scheduleDate??DateTime.now(), format: dateFormatWithHalfMonthName))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock_clock,
                                    color: iconColor,
                                    size: 15,
                                  ),
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
                                  Text(
                                    "End Time",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.lock_clock,
                                    color: iconColor,
                                    size: 15,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2,left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                convertTimeTo12Hours(time: data[index].startTime ?? "", format: timeFormat12Hours),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(convertTimeTo12Hours(time: data[index].endTime ?? "", format: timeFormat12Hours),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
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

  Widget _noAppointmentView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sorry, No upcoming appointments",
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
