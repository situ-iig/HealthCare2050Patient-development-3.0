import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/internet/widgets/internet_view.dart';
import 'package:nb_utils/nb_utils.dart';

class InternetConnectionScreen extends StatefulWidget {
  const InternetConnectionScreen({Key? key}) : super(key: key);

  @override
  State<InternetConnectionScreen> createState() => _InternetConnectionScreenState();
}

class _InternetConnectionScreenState extends State<InternetConnectionScreen> {
  DateTime? pressedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: (){
          if(_onWillPopup() == true){
            return exit(0);
          }else{
            return Future.value(false);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // topTitleNoInternet(),
            // 100.height,
            notConnectionImageView(),
            20.height,
            internetMessage(),
            40.height,
            InkWell(
                onTap: () async {
                  var internet = await _checkConnectivity();
                  if (internet == true) {
                    finish(context);
                  } else {
                    _showNotInternetSnackBar(context);
                    await _checkConnectivity();
                  }
                },
                child: tryAgainButton())
          ],
        ),
      ),
    );
  }

  _showNotInternetSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: (Text("You are not connected with internet")),
      duration: Duration(seconds: 1),
    ));
  }

  Future<bool> _checkConnectivity() async {
    final _connectivity = Connectivity();
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.none) {
      return false;
    } else if (connectionResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectionResult == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }
  }

   _onWillPopup(){
    var now = DateTime.now();
    if(pressedTime == null || now.difference(pressedTime!)> Duration(seconds: 2)){
      pressedTime = now;
      Fluttertoast.showToast(msg: "Double press to exit app");
      return false;
    }
    return true;
  }
}
