import 'package:flutter/material.dart';

import '../../history/today_appointments/widgets/tab_bar_view.dart';
import '../active_appointments_screen.dart';

class ActiveAppointmentsTabView extends StatefulWidget {
  const ActiveAppointmentsTabView({Key? key}) : super(key: key);

  @override
  State<ActiveAppointmentsTabView> createState() =>
      _ActiveAppointmentsTabViewState();
}

class _ActiveAppointmentsTabViewState extends State<ActiveAppointmentsTabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Active Appointments"),
            bottom: tabBarView([
              Tab(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.video_call_outlined), Text("Video")],
                  )),
              Tab(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.call), Text("Telephone")],
                  )),
            ]),
          ),
          body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
            ActiveAppointmentScreen(showAppBar: false,consultType: "1",),
            ActiveAppointmentScreen(showAppBar: false,consultType: "2"),
          ]),
        ));
  }
}
