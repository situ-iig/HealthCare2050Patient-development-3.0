import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/history/upcoming_appointment/upcoming_appointment_screen.dart';

import '../../../../utils/helpers/internet_helper.dart';
import '../today_appointments/widgets/tab_bar_view.dart';

class UpcomingAppointmentTabView extends StatelessWidget {
  const UpcomingAppointmentTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Upcoming Appointments"),
            bottom: tabBarView([
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_hospital_outlined),
                    Text("Offline")
                  ],
                ),
              ),
              Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.video_call_outlined),
                      Text("Video")
                    ],
                  )
              ),
              Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call),
                      Text("Telephone")
                    ],
                  )
              )
            ]),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
              children: [
            UpcomingAppointmentScreen(consultType: "3",),
            UpcomingAppointmentScreen(consultType: "1",),
            UpcomingAppointmentScreen(consultType: "2",),
          ]),
        ));
  }
}
