
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/constants/basic_strings.dart';
import 'package:healthcare2050/view/pages/doctor/all_doctor_list_screen.dart';
import 'package:healthcare2050/view/pages/searches/search_city_screen.dart';
import 'package:healthcare2050/constants/constants.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/utils/helpers/url_helper.dart';
import 'package:healthcare2050/view/pages/history/history_tab_view.dart';
import 'package:healthcare2050/view/pages/history/today_appointments/today_appointment_tab_view.dart';
import 'package:healthcare2050/view/pages/history/upcoming_appointment/upcoming_appointments_tab_view.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:healthcare2050/view/pages/profile/user_profile_screen.dart';
import 'package:healthcare2050/view/widgets/login_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../pages/landing/widgets/landing_floating_widget.dart';
import '../pages/searches/search_service_screen.dart';
import '../../utils/data/local_data_keys.dart';
import '../pages/auth/phone_auth_screen.dart';

class SideDrawer extends StatefulWidget {
  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {

  bool hasLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus();
  }

  checkLoggedInStatus() async {
    await getBoolFromLocal(loggedInKey).then((value) {
      setState(() {
        hasLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: themColor,
        child: ListView(
          children: <Widget>[
            20.height,
            buildHeader(
              name: appName,
              onClicked: () async {
                finish(context);
                ShowLoginDialogInView()
                    .checkLoginStatus(context, UserProfileScreen());
              },
            ),
            Divider(
              color: Colors.white,
            ),
            Container(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildMenuItem(
                    text: 'Home',
                    icon: CupertinoIcons.home,
                    onClicked: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LandingScreen()),
                        (route) => false),
                  ),
                  _expansionDrawerItem([
                    buildMenuItem(
                        text: "Today's Appointment",
                        icon: CupertinoIcons.doc_text,
                        onClicked: () async {
                          finish(context);
                          ShowLoginDialogInView().checkLoginStatus(
                              context, TodayAppointmentTabView());
                        }),
                    buildMenuItem(
                        text: "Upcoming Appointment",
                        icon: CupertinoIcons.doc_text,
                        onClicked: () async {
                          finish(context);
                          ShowLoginDialogInView().checkLoginStatus(
                              context, UpcomingAppointmentTabView());
                        }),
                    buildMenuItem(
                        text: 'Appointment History',
                        icon: CupertinoIcons.alarm,
                        onClicked: () async {
                          finish(context);
                          ShowLoginDialogInView()
                              .checkLoginStatus(context, HistoryTavView());
                        }),
                  ], CupertinoIcons.doc_text, "Appointments"),
                  buildMenuItem(
                    text: 'Our Doctors',
                    icon: CupertinoIcons.person,
                    onClicked: () => Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) => AllDoctorListScreen())),
                  ),
                  // buildMenuItem(
                  //   text: 'Talk with us',
                  //   icon: CupertinoIcons.conversation_bubble,
                  //   onClicked: (){
                  //     finish(context);
                  //     Navigator.of(context,)
                  //         .push(MaterialPageRoute(
                  //         builder: (context) => TalkWithUsScreen()));
                  //   },
                  // ),
                  Divider(color: Colors.white70),
                  _expansionDrawerItem([
                    buildMenuItem(
                      text: 'Search Service',
                      icon: CupertinoIcons.archivebox,
                      onClicked: () {
                        finish(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SearchServiceScreen()));
                      },
                    ),
                    buildMenuItem(
                      text: 'Search Location',
                      icon: CupertinoIcons.map_pin_ellipse,
                      onClicked: () {
                        finish(context);
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SearchCityScreen()));
                      },
                    ),
                  ], CupertinoIcons.search, "Search Us"),
                  Divider(color: Colors.white70),
                  buildMenuItem(
                    text: 'About Us',
                    icon: CupertinoIcons.info,
                    onClicked: () =>
                        launchURL(aboutUsUrl),
                  ),
                  buildMenuItem(
                    text: 'Contact Us',
                    icon: Icons.contact_mail_outlined,
                    onClicked: () => launchURL(
                        contactUsUrl),
                  ),
                  hasLoggedIn == true
                      ? buildMenuItem(
                          text: 'Sign Out',
                          icon: Icons.logout,
                          onClicked: () async {
                            finish(context);
                            _askLogOutDialog(context);
                          })
                      : Container(),
                  buildMenuItem(
                    text: 'Exit',
                    icon: Icons.exit_to_app,
                    onClicked: () => showAppExitDialog(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    child: Image.asset(
                      "assets/Logo/logo_png.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "WorkSans"),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_forward, color: themGreenColor),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    void Function()? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

_askLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Logout Alert!"),
            content: Text("Are you sure? Do you want to logout?"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                  onPressed: () {
                    finish(context);
                  },
                  child: Text("No")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    finish(context);
                    SharedPreferences loginPrefs =
                        await SharedPreferences.getInstance();
                    loginPrefs.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneAuthScreen()),
                        (route) => false);
                  },
                  child: Text("Yes"))
            ],
          ));

}

_expansionDrawerItem(List<Widget> items,IconData tileIcon,String title){
  return ExpansionTile(
    backgroundColor: Colors.grey.withOpacity(.1),
    childrenPadding: EdgeInsets.symmetric(horizontal: 10),
      trailing: Icon(Icons.keyboard_arrow_down,color: themAmberColor,),
      iconColor: Colors.white,
      leading: Icon(
        tileIcon,
        color:  themAmberColor
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16.0,
            color: themAmberColor,
            fontWeight: FontWeight.bold),
      ),
      children: items);
}


/// 2050 iCare or 2050iCare
