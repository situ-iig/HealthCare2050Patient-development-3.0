import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthcare2050/Api/Api.dart';
import 'package:healthcare2050/Model/appointments/doctor_appointment_model.dart';
import 'package:healthcare2050/services/appointments/offline_appointment_apis.dart';
import 'package:healthcare2050/utils/constants/basic_strings.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/constants/constants.dart';
import 'package:healthcare2050/view/pages/book_appointment/offline/widgets/offline_appointment_preview_widget.dart';
import 'package:healthcare2050/view/pages/payment/widgets/payment_successful_widget.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../Model/patient/add_patient_details_model.dart';
import '../../../../utils/helpers/internet_helper.dart';

class AppointmentPreviewPageScreen extends StatefulWidget {
  final DoctorAppointmentModel doctorDetails;
  final String slotTiming,amount;
  final AddPatientDetailsModel patientDetails;

  const AppointmentPreviewPageScreen(
      {Key? key,
      required this.doctorDetails,
      required this.slotTiming, required this.patientDetails, required this.amount})
      : super(key: key);

  @override
  State<AppointmentPreviewPageScreen> createState() =>
      _AppointmentPreviewPageScreenState(
          doctorDetails, patientDetails);
}

class _AppointmentPreviewPageScreenState
    extends State<AppointmentPreviewPageScreen> {
  final DoctorAppointmentModel doctorDetails;
  final AddPatientDetailsModel patientDetails;

  int advancePaymentOf = 1;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  _AppointmentPreviewPageScreenState(
      this.doctorDetails, this.patientDetails);


  String orderId = "";
  String paymentId = "";

  goToRazorpayPaymentProcess(String scheduleId) async {
    var userId = await getStringFromLocal(userIdKey);
    var response =
        await http.post(Uri.parse(goToRazorPayApi.toString()), body: {
      "userId": userId,
      "bookscheduleid": scheduleId,
      "amount": widget.amount,
    });
    if (response.statusCode == 200) {
      var items = json.decode(response.body) ?? {};
      bool status = items['status'] ?? false;
      if (status == true) {
        orderId = items['orderId'].toString();
        setState(() {});
        await launchRazorPay();
      }
    } else {
      setState(() {

      });
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  launchRazorPay() async {
    var amount = int.parse(widget.amount);
    int amountToPay = amount * 100;

    var options = {
      'key': razor_live_key,
      'order_id': orderId,
      'amount': amountToPay,
      'prefill': {
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
      Logger().i("payment_error $e");
      print("Error: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var payId = response.paymentId;
    var orId = response.orderId;
    await OfflineAppointmentApi().updatePaymentDetails(payId??"", orId??"").then((value){
      if(value == true){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentSuccessfulView(),
              fullscreenDialog: true),
        );
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _paymentFailedDialog();
    print("${response.code}\n${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Payment Failed");
  }

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Preview"),
        backgroundColor: themColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
      ),
      body: Container(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                OfflineAppointmentPreviewWidget.doctorDetailsView(doctorDetails),
                OfflineAppointmentPreviewWidget.patientDetailsView(patientDetails.patientName,patientDetails.patientAge,patientDetails.patientGender,patientDetails.patientMobile),
                OfflineAppointmentPreviewWidget.slotDetailsView(widget.slotTiming,patientDetails.consultDate),
                OfflineAppointmentPreviewWidget.paymentDetailsView(doctorDetails.price.toString()),
                30.height,
                SizedBox(
                  height: 70,
                  child: Builder(
                    builder: (context) {
                      final GlobalKey<
                          SlideActionState>
                      _key =
                      GlobalKey();
                      return Padding(
                        padding:
                        const EdgeInsets
                            .all(8.0),
                        child: SlideAction(
                          innerColor:
                          Colors.white,
                          outerColor:
                          Colors.green,
                          text:
                          "Slide To Payment",
                          sliderButtonIconSize:
                          20,
                          sliderButtonIconPadding:
                          10,
                          sliderButtonIcon:
                          Icon(
                            Icons
                                .arrow_forward,
                            color:
                            Colors.green,
                          ),
                          key: _key,
                          onSubmit: () {
                            LoaderDialogView(context).showLoadingDialog();
                            OfflineAppointmentApi()
                                .postDataToOfflineDoctorConsult(
                                    context,
                                    patientDetails)
                                .then((value) {
                              LoaderDialogView(context).dismissLoadingDialog();
                              if (value == true) {
                                LoaderDialogView(context).showLoadingDialog();
                                OfflineAppointmentApi().getPaymentId().then((value){
                                  LoaderDialogView(context).dismissLoadingDialog();
                                  if(value['0'] == true){
                                    var scheduleId = value['1'];
                                    goToRazorpayPaymentProcess(scheduleId);
                                  }else{
                                    setState(() {
                                    });
                                    Fluttertoast.showToast(msg: "Something went wrong");
                                  }
                                });
                              } else {
                                Fluttertoast.showToast(msg: "Data not successful");
                              }
                            });

                          },
                          submittedIcon:
                          Icon(
                            Icons.done_outline_outlined,
                            color: Colors
                                .white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }

  _paymentFailedDialog() {
    return showGeneralDialog(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Scaffold(
            body: Container(color: Colors.white,
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
                        _dialogButton(Colors.red, "Not Now", onPressed: (){
                          finish(context);
                        }),
                        20.width,
                        _dialogButton(Colors.green, "Try Again", onPressed: (){
                          launchRazorPay();
                        }),
                      ],
                    )
                  ],
                ),
              ),),
          );
        },
        context: context);
  }

  _dialogButton(Color btnColor,String text,{required void Function()? onPressed}){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: btnColor,fixedSize: Size(35.w, 5.h)),
        onPressed: onPressed, child: Text(text));
  }
}
