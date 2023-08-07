import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/view/pages/history/today_appointments/today_appointment_screen.dart';
import 'package:healthcare2050/view/pages/history/today_appointments/widgets/tab_bar_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/helpers/internet_helper.dart';
import '../../auth/phone_auth_screen.dart';

class TodayAppointmentTabView extends StatefulWidget {
  const TodayAppointmentTabView({Key? key}) : super(key: key);

  @override
  State<TodayAppointmentTabView> createState() =>
      _TodayAppointmentTabViewState();
}

class _TodayAppointmentTabViewState extends State<TodayAppointmentTabView> {
  bool hasLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  checkLoginStatus() async {
    if (await getBoolFromLocal(loggedInKey) == true) {
      setState(() {
        hasLoggedIn = true;
      });
    } else {
      setState(() {
        hasLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return hasLoggedIn == true
        ? DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Today's Appointments"),
                bottom: tabBarView([
                  Tab(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_call_outlined),
                          Text("Video")
                        ],
                      )),
                  Tab(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.call), Text("Telephone")],
                      )),
                  Tab(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.meeting_room), Text("Offline")],
                    ),
                  ),
                ]),
              ),
              body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    TodayAppointmentScreen(
                      consultType: "1",
                    ),
                    TodayAppointmentScreen(
                      consultType: "2",
                    ),
                    TodayAppointmentScreen(
                      consultType: "3",
                    ),
                  ]),
            ))
        : _notLoggedInView();
  }

  _notLoggedInView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Currently you are not logged in.",
            style: boldTextStyle(color: textColor, size: 20),
          ),
          20.height,
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PhoneAuthScreen()),
                    (route) => false);
              },
              child: Text("Login Now"))
        ],
      ),
    );
  }
}
