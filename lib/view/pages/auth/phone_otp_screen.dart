import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/auth/auth_response_model.dart';
import 'package:healthcare2050/Providers/user_details_provider.dart';
import 'package:healthcare2050/services/auth/phone_auth_services.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/view/pages/auth/widgets/otp_widgets.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:healthcare2050/view/widgets/route_navigators.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../utils/colors.dart';
import '../../../utils/data/local_data_keys.dart';
import '../../../utils/helpers/internet_helper.dart';
import '../../widgets/loader_dialog_view.dart';

class PhoneOTPScreen extends StatefulWidget {
  final String phoneNumber;

  const PhoneOTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<PhoneOTPScreen> createState() => _PhoneOTPScreenState();
}

class _PhoneOTPScreenState extends State<PhoneOTPScreen> with CodeAutoFill {
  String currentOTP = '';
  String appSignature = '';
  bool showResendOtpButton = false;
  Timer _timer = Timer(Duration(seconds: 0), () {});

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});

    listenForCode();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    SmsAutoFill().unregisterListener();
    cancel();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          otpImageView().paddingAll(10),
          10.height,
          Center(child: otpMessage(widget.phoneNumber)),
          20.height,
          5.height,
          OTPFieldView().paddingSymmetric(horizontal: 16),
          30.height,
          buildResendOTPView(showResendOtpButton == true
              ? InkWell(
                  onTap: () {
                    setState(() {
                      showResendOtpButton = false;
                    });
                    getAuthOTP(widget.phoneNumber);
                  },
                  child: Text(" Resend",
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          fontFamily: 'Ubuntu')),
                )
              : _showCountDownView())
        ],
      ),
    );
  }

  Widget OTPFieldView() {
    return PinFieldAutoFill(
      autoFocus: false,
      codeLength: 6,
      cursor: Cursor(color: textColor, enabled: true, height: 20, width: 2),
      decoration: UnderlineDecoration(
        gapSpace: 10,
        textStyle: TextStyle(fontSize: 20, color: Colors.black),
        colorBuilder: FixedColorBuilder(textColor),
      ),
      onCodeSubmitted: (code) async {
        submitOtp(code);
      },
      onCodeChanged: (code) {
        if (code!.length == 6) {
          submitOtp(code);
        } else {}
      },
    );
  }

  submitOtp(String code) async {
    var provider = Provider.of<UserDetailsProvider>(context, listen: false);
    LoaderDialogView(context).showLoadingDialog();
    var response = await verifyPhoneOTP(code, widget.phoneNumber);

    if (response['status'] == true) {
      LoaderDialogView(context).dismissLoadingDialog();
      storeUserData(response['data'], provider);
    } else {
      LoaderDialogView(context).dismissLoadingDialog();
      Fluttertoast.showToast(msg: "OTP Not Matched");
    }
  }

  storeUserData(AuthResponseModel data, UserDetailsProvider provider) async {
    await storeStringToLocal(userIdKey, data.userDetails?.id.toString() ?? "");

    await storeStringToLocal(userNameKey, data.userDetails?.fullName ?? "");
    await storeStringToLocal(userEmailKey, data.userDetails?.email ?? "");
    await storeStringToLocal(
        userMobileKey, data.userDetails?.mobileNumber ?? "");
    await storeStringToLocal(userAddressKey, data.userDetails?.address ?? "");

    provider.addMobile(data.userDetails?.mobileNumber ?? "");
    provider.addEmail(data.userDetails?.email ?? "");
    provider.addCity(data.userDetails?.city ?? "");
    provider.addPinCode(data.userDetails?.pincode ?? "");
    provider.addState(data.userDetails?.state ?? "");
    provider.addProfilePic(data.userDetails?.image ?? "");
    provider.addAddress(data.userDetails?.address ?? "");
    provider.addUserId(data.userDetails?.id.toString() ?? "");

    goToLandingPage();
  }

  goToLandingPage() async {
    await storeBoolToLocal(loggedInKey, true);
    navigateToNextPageWithRemoveUntil(context, LandingScreen(), duration: 1);
  }

  _showCountDownView() {
    return Countdown(
      controller: CountdownController(autoStart: true),
      seconds: 60,
      build: (BuildContext context, double time) => Text(
        "$time s",
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      onFinished: () {
        setState(() {
          showResendOtpButton = true;
        });
        print('Timer is done!');
      },
    );
  }

  @override
  void codeUpdated() {
    setState(() {
      currentOTP = code!;
    });
  }
}
