import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/services/auth/phone_auth_services.dart';
import 'package:healthcare2050/utils/constants/basic_strings.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';
import 'package:healthcare2050/utils/helpers/url_helper.dart';
import 'package:healthcare2050/view/pages/auth/phone_otp_screen.dart';
import 'package:healthcare2050/view/pages/auth/widgets/phone_widget.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../widgets/route_navigators.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String phoneNumber = "";
  final phoneKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: phoneKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            phoneAuthImageView(),
            phoneCardView(phoneAuthTextField((phone) {
              setState(() {
                phoneNumber = phone.number;
              });
            })),
            20.height,
            _conditionCheckBox(),
            5.height,
            isChecked == true
                ? getOTPButtonView(onCLick: () {
                    if (phoneKey.currentState!.validate()) {
                      LoaderDialogView(context).showLoadingDialog();
                      getAuthOTP(phoneNumber).then((value) {
                        if (value['status'] == true) {
                          LoaderDialogView(context).dismissLoadingDialog();
                          PhoneOTPScreen(
                            phoneNumber: phoneNumber,
                          ).launch(context,pageRouteAnimation: PageRouteAnimation.Scale);
                        } else {
                          LoaderDialogView(context).dismissLoadingDialog();
                          Fluttertoast.showToast(msg: "Otp Not Found");
                        }
                      });
                    }
                  })
                : conditionNotSelectedView(context),
            20.height,
            InkWell(
              onTap: () {
                navigateToNextPageWithRemoveUntil(context, LandingScreen(),duration: 1);
              },
              child: guestUserView(),
            )
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    );
  }

  _conditionCheckBox() {
    return Row(
      children: [
        Checkbox(
            checkColor: Colors.white,
            side: BorderSide(width: 2, color: iconColor),
            activeColor: iconColor,
            value: isChecked,
            onChanged: (value) {
              isChecked = value ?? false;
              setState(() {});
            }),
        Flexible(
          child: RichText(
              text: TextSpan(
                  text: "By singing up, You're agree to our ",
                  children: [
                    TextSpan(
                        text: "Terms & Conditions",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchURL(termsConditionUrl);
                          },
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: textColor,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " and ",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    TextSpan(
                        text: "Privacy Policy.",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchURL(policyUrl);
                          },
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold))
                  ],
                  style: TextStyle(color: Colors.black, fontSize: 12))).paddingOnly(right: 10),
        )
      ],
    );
  }
}
