import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/helpers/notification_helper.dart';
import 'package:healthcare2050/view/pages/auth/phone_auth_screen.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:healthcare2050/view/pages/splash/widgets/splash_widgets.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/view/widgets/route_navigators.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/helpers/internet_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     // checkInternetConnection();
    checkInternetStatus();
    onMessageNotification();
    onOpenAppNotification(context);
  }

  checkInternetConnection() async {
    var internetHelper = InternetHelper(context: context);
    var internet = await internetHelper.checkConnectivity();
    await internetHelper.checkConnectivityRealTime(
      callBack: (status){
        if(status == true){
          checkInternetStatus();
        }
      }
    );
    if (internet == true) {
      checkInternetStatus();
    }
  }

  checkInternetStatus() {
    Future.delayed(Duration(seconds: 3), () async {
      if (await getBoolFromLocal(loggedInKey) == true) {
        navigateToNextPageWithRemoveUntil(context, LandingScreen(),duration: 1);
      } else {
        goToNextPage(PhoneAuthScreen());
      }
    });
  }
  
  goToNextPage(Widget nextPage){
    return Navigator.pushAndRemoveUntil(context,PageRouteBuilder(
      pageBuilder: (_, __, ___) => nextPage,
      transitionDuration: Duration(seconds: 2),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
    ), (route) => false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashScreenColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          splashLogoDecoration(splashImageView(),),
          10.height,
          splashTitle(),
          60.height,
          splashMessage().paddingSymmetric(horizontal: 16)
        ],
      ),
    );
  }

}
