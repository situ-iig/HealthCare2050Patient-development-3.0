import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/helpers/internet_helper.dart';

class PaymentSuccessfulView extends StatelessWidget {
  String? message;
   PaymentSuccessfulView({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return goToHome(context);
        },
        child: Center(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/gif/payment_successful.gif",
                    ),
                    20.height,
                    Text(
                      'Appointment successfully booked.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    5.height,
                    Text(
                      message??'Your payment successful and also appointment booked',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    40.height,
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,fixedSize: Size(80.w, 5.5.h)),
                        onPressed: () {
                          goToHome(context);
                        },
                        child: Text("Okay"))
                  ],
                ),
              ),
              Positioned(
                top: 50,
                  right: 15,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                    ),
                child: IconButton(onPressed: () {
                  goToHome(context);
                }, icon: Icon(Icons.clear,color: Colors.grey,)),
              ))
            ],
          ),
        ),
      ),
    );
  }

  goToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
        (route) => false);
  }
}
