import 'package:flutter/material.dart';
import 'package:healthcare2050/Providers/user_details_provider.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';
import 'package:healthcare2050/view/pages/profile/widgets/profile_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'edit_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (a) {});
    Provider.of<UserDetailsProvider>(context, listen: false).getUserDetails();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<UserDetailsProvider>(context, listen: false).getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                EditProfileScreen().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Slide,
                    duration: Duration(milliseconds: 500));
              },
              icon: Icon(Icons.edit)),
        ],
      ),
      body: Container(
        height: 100.h,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 73.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: secondaryBgColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: _userDetailsView(),
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Consumer<UserDetailsProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return Center(
                    child: profileImageView(
                        "$pictureServerPath${value.getProfileImage}",
                        context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userDetailsView() {
    return Consumer<UserDetailsProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          color: secondaryBgColor,
          child: ListView(
            children: [
              userDetailsItemView(
                  "Your mobile number", value.getMobile, context),
              userDetailsItemView(
                  "Your email address", value.getEmail, context),
              userDetailsItemView("Your address", value.getAddress, context),
              userDetailsItemView("Your pin code", value.getPinCode, context),
              userDetailsItemView("Your city name", value.getCityName, context),
              userDetailsItemView(
                  "Your state name", value.getStateName, context),
            ],
          ),
        ).paddingOnly(top: 100);
      },
    );
  }
}
