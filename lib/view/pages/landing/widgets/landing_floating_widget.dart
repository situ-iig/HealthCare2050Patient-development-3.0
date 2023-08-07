import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/our_presence/our_presence_screen.dart';
import 'package:healthcare2050/view/widgets/login_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../google_maps/google_maps_screen.dart';
import '../../request/request_a_service_screen.dart';
import '../../searches/search_city_screen.dart';
import '../../searches/search_service_screen.dart';
import '../../../../utils/colors.dart';

class LandingFloatingView extends StatelessWidget {
  const LandingFloatingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            elevation: 4,
            context: context,
            builder: (context) {
              return Column(
                children: <Widget>[
                  Icon(Icons.linear_scale_sharp),
                  20.height,
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // floatingListTileItem(context, false,
                            //     title: "Our Doctors",
                            //     subtitle: "Book Appointment with doctors",
                            //     goTo: AllDoctorListPage(),
                            //     icon: Icons.medical_services_rounded),
                            // floatingListTileItem(context, true,
                            //     title: "Profile",
                            //     subtitle: "Edit and update profile",
                            //     goTo: UserProfileScreen(),
                            //     icon: Icons.person),
                            floatingListTileItem(context, false,
                                title: "Our Presence",
                                subtitle: "Find our service to your area",
                                goTo: OurPresenceScreen(),
                                icon: Icons.location_on_outlined),
                            floatingListTileItem(context, false,
                                title: "Find on map",
                                subtitle: "See our presence on map",
                                goTo: GoogleMapScreen(),
                                icon: Icons.search_rounded),
                            floatingListTileItem(context, false,
                                title: "Search by Service",
                                subtitle: "Search here by service",
                                goTo: SearchServiceScreen(),
                                icon: Icons.manage_search),
                            floatingListTileItem(context, true,
                                title: "Request Service",
                                subtitle: "Request a service here",
                                goTo: RequestAServiceScreen(),
                                icon: Icons.medication_liquid_sharp),
                            floatingListTileItem(context, true,
                                title: "Search by City",
                                subtitle: "Search our service to your city",
                                goTo: SearchCityScreen(),
                                icon: Icons.location_city),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            });
      },
      tooltip: "Get More Options",
      child: Icon(Icons.more_vert, color: appBarColor, size: 30),
      elevation: 4.0,
      backgroundColor: Colors.white,
    );
  }

  floatingListTileItem(BuildContext context, bool shouldCheckLogin,
      {required String title,
      required String subtitle,
      required Widget goTo,
      required IconData icon}) {
    return ListTile(
      tileColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        leading: Icon(
          icon,
          color: iconColor,
        ),
        title: Text(
          title,
          style: boldTextStyle(color: textColor),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey),
        ),
        onTap: () {
          if (shouldCheckLogin == true) {
            finish(context);
            ShowLoginDialogInView().checkLoginStatus(context, goTo);
          } else {
            finish(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => goTo));
          }
        });
  }
}

Future<bool> showAppExitDialog(BuildContext context) async {
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('App Exit!'),
      content: const Text('Are you sure? Do you want to exit an App?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => exit(0),
          child: const Text('Yes',style: TextStyle(color: Colors.red),),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No',style: TextStyle(color: Colors.green)),
        ),
      ],
    ),
  )) ?? false;
}
