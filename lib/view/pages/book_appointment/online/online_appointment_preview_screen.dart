import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/appointments/online/online_doctor_model.dart';
import 'package:healthcare2050/Model/patient/add_patient_details_model.dart';
import 'package:healthcare2050/services/appointments/online_appointment_apis.dart';
import 'package:healthcare2050/utils/constants/basic_strings.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:healthcare2050/view/pages/book_appointment/online/widgets/online_appointment_preview_widget.dart';
import 'package:healthcare2050/view/pages/landing/landing_screen.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../utils/data/local_data_keys.dart';
import '../../../../utils/data/shared_preference.dart';
import '../../payment/widgets/payment_successful_widget.dart';

class OnlineAppointmentPreviewScreen extends StatefulWidget {
  final OnlineDoctorsModel doctorsModel;
  final AddPatientDetailsModel patientDetails;
  final String slotTiming;

  const OnlineAppointmentPreviewScreen({
    Key? key,
    required this.doctorsModel,
    required this.slotTiming,
    required this.patientDetails,
  }) : super(key: key);

  @override
  State<OnlineAppointmentPreviewScreen> createState() =>
      _OnlineAppointmentPreviewScreenState(doctorsModel, patientDetails);
}

class _OnlineAppointmentPreviewScreenState
    extends State<OnlineAppointmentPreviewScreen> {
  final OnlineDoctorsModel doctorsModel;
  final AddPatientDetailsModel patientDetails;

  _OnlineAppointmentPreviewScreenState(this.doctorsModel, this.patientDetails);

  late Razorpay _razorpay;
  String orderId = "";
  String paymentId = "";
  bool showShimmer = true;

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (a) {});
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    var appointmentFee =
        Provider.of<OnlineAvailableSlotProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Preview"),
      ),
      body: ListView(
        children: [
          OnlineAppointmentPreviewWidget.doctorDetailsView(doctorsModel),
          OnlineAppointmentPreviewWidget.patientDetailsView(
              patientDetails.patientName,
              patientDetails.patientAge,
              patientDetails.patientGender,
              patientDetails.patientMobile),
          OnlineAppointmentPreviewWidget.slotDetailsView(
              widget.slotTiming, patientDetails.consultDate),
          OnlineAppointmentPreviewWidget.paymentDetailsView(
              appointmentFee.appointmentFee),
          20.height,
          slidButtonView(appointmentFee.appointmentFee),
        ],
      ),
    );
  }

  Widget slidButtonView(String amount) {
    final GlobalKey<SlideActionState> _key = GlobalKey();
    return SizedBox(
      width: screenWidth(context)-20,
      child: SlideAction(
        height: 55,
        elevation: 5,
        animationDuration: Duration(seconds: 1),
        sliderRotate: true,
        innerColor: Colors.white,
        outerColor: Colors.green,
        text: "Slide To Payment",
        sliderButtonIconSize: 20,
        sliderButtonIconPadding: 10,
        sliderButtonIcon: Icon(
          Icons.arrow_forward,
          color: Colors.green,
        ),
        key: _key,
        onSubmit: () async {
          proceedToPayment(amount);
        },
        submittedIcon: Icon(
          Icons.done_outline_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  proceedToPayment(String amount) async {
    LoaderDialogView(context).showLoadingDialog();
    OnlineAppointmentsApis()
        .addPatientDetailsForOnlineConsultation(patientDetails)
        .then((value) {
      LoaderDialogView(context).dismissLoadingDialog();
      if (value == true) {
        LoaderDialogView(context).showLoadingDialog();
        OnlineAppointmentsApis().generatePayment().then((value) async {
          print(value.toString());
          LoaderDialogView(context).dismissLoadingDialog();
          if (value['status'] == true) {
            var scheduleId = value['id'];
            await OnlineAppointmentsApis()
                .goToRazorpayPaymentProcess(scheduleId.toString(), amount)
                .then((value) {
              if (value['status'] == true) {
                setState(() {});
                orderId = value['orderId'];
                print("razorpay id $orderId");
                launchRazorPay(amount);
              } else {
                setState(() {});
              }
            });
          } else {
            setState(() {});
          }
        });
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  void launchRazorPay(String amount) async {
    int amountToPay = int.parse(amount) * 100;

    var options = {
      'key': razor_live_key,
      'order_id': orderId,
      'amount': "$amountToPay",
      'prefill': {
        'name':patientDetails.patientName,
        'contact': await getStringFromLocal(userMobileKey),
        'email': await getStringFromLocal(userEmailKey)
      },
      "config": {
        "display": {
          "hide": [
            {
              'method': 'paylater',
            },
            {
              'method': 'emi',
            }
          ],
          "preferences": {
            "show_default_blocks": "true",
          },
        },
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(
        "${response.orderId} \n${response.paymentId} \n${response.signature}");

    setState(() {
      paymentId = response.paymentId ?? "";
    });
    var paymentStatus =
        await OnlineAppointmentsApis().submitPaymentDetails(orderId, paymentId);
    if (paymentStatus == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentSuccessfulView(),
            fullscreenDialog: true),
      );
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
          (route) => false);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _paymentFailedDialog();

    print("${response.code}\n${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Payment Failed");
  }

  _paymentFailedDialog() {
    var appointmentFee =
        Provider.of<OnlineAvailableSlotProvider>(context, listen: false);
    return showGeneralDialog(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/gif/payment_failed.gif"),
                    20.height,
                    Text('Your payment failed, please try again.'),
                    40.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _dialogButton(Colors.red, "Not Now", onPressed: () {
                          finish(context);
                        }),
                        20.width,
                        _dialogButton(Colors.green, "Try Again", onPressed: () {
                          launchRazorPay(appointmentFee.appointmentFee);
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        context: context);
  }

  _dialogButton(Color btnColor, String text,
      {required void Function()? onPressed}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: btnColor, fixedSize: Size(35.w, 5.h)),
        onPressed: onPressed,
        child: Text(text));
  }
}
