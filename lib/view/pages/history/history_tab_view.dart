import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/history/history_screen.dart';
import 'package:healthcare2050/view/pages/history/today_appointments/widgets/tab_bar_view.dart';

import '../../../utils/helpers/internet_helper.dart';

class HistoryTavView extends StatelessWidget {
  const HistoryTavView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Appointments History"),
            bottom: tabBarView([
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.meeting_room),
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
            HistoryScreen(consultType: "3",),
            HistoryScreen(consultType: "1",),
            HistoryScreen(consultType: "2",),
          ]),
        ));
  }
}
