import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/styles/button_styles.dart';
import '../../../../constants/constants.dart';

Widget otpImageView() {
  return Image.asset("assets/images/otp.gif");
}
Text otpMessage(String mobile){
  return Text("We have sent 6 digit OTP to $mobile.",textAlign: TextAlign.center,);
}

Text otpEditFieldTitle() {
  return Text("Enter OTP here...",
      style: TextStyle(
          color: Colors.black,
          // fontWeight: FontWeight.w600,
          fontSize: 14,
          ));
}

Widget buildOtpButton(void Function() onPressed) {
  return ElevatedButton(
      style: phoneAuthButtonStyle(),
      onPressed: onPressed,
      child: Text(
        "Verify OTP",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ));
}

Widget buildResendOTPView(Widget child) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Did not receive an otp?",
          style: TextStyle(
              color: themRedColor,
              fontWeight: FontWeight.w200,
              fontSize: 16,
              fontFamily: 'Ubuntu')),
      SizedBox(width: 10,),
      child

    ],
  );
}
