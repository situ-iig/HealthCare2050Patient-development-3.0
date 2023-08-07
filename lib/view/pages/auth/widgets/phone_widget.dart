import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:healthcare2050/view/pages/auth/widgets/phone_auth_decorations.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/styles/button_styles.dart';

Widget phoneAuthImageView() {
  return Image.asset(
    'assets/images/registration.png',
    height: 30.h,
    width: 80.w,
  );
}

phoneAuthTextField(
  void Function(PhoneNumber)? onChanged,
) {
  return IntlPhoneField(
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      hintText: "Your Mobile No.",
      hintStyle: TextStyle(fontSize: 12),
      //helperText: "Enter Mobile No. here...",
      counterText: "",
      border: phoneInputBorder(),
      enabledBorder: phoneInputBorder(),
      focusedBorder: phoneFocusBorder(),
    ),
    validator: (text) {
      if (text!.number.length <= 9) {
        return "Please enter a valid number";
      } else {
        return null;
      }
    },
    initialCountryCode: 'IN',
    dropdownIcon: Icon(
      Icons.arrow_drop_down_outlined,
      color: iconColor,
    ),
    cursorColor: cursorColor,
    onChanged: onChanged,
  ).paddingSymmetric(horizontal: 2, vertical: 2);
}

phoneCardView(Widget child) {
  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: child,
  );
}

getOTPButtonView({void Function()? onCLick}) {
  return ElevatedButton(
      style: phoneAuthButtonStyle(),
      onPressed: onCLick,
      child: Text(
        "Get OTP",
        style: boldTextStyle(color: Colors.white),
      ));
}

Widget conditionNotSelectedView(BuildContext context) {
  return InkWell(
    onTap: (){
      Fluttertoast.showToast(msg: 'Please accept our policy and proceed, otherwise you can not proceed.');
    },
    child: Container(
        height: screenHeight(context)/16,
        width: screenWidth(context),
        decoration:
            boxDecorationRoundedWithShadow(8, backgroundColor: Colors.grey),
        child: Center(
          child: Text(
            "Get OTP",
            style: boldTextStyle(color: Colors.white),
          ),
        )),
  );
}

guestUserView() {
  return Text(
    "Guest User? Click Here",
    style: boldTextStyle(color: Colors.green),
  );
}
