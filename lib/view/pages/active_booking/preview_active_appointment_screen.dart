import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/patient/add_patient_details_model.dart';
import 'package:healthcare2050/services/active_appointments/active_appointments_apis.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/view/pages/payment/widgets/payment_successful_widget.dart';
import 'package:healthcare2050/view/pages/active_booking/widgets/preview_appointment_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Model/active_appointments/active_appointment_model.dart';
import '../../../utils/helpers/internet_helper.dart';
import '../../widgets/loader_dialog_view.dart';

class PreviewActiveAppointmentScreen extends StatefulWidget {
  final ActiveAppointmentModel data;
  final String consultType;
  final String date;
  final String slotId;
  final String slotTiming;

  const PreviewActiveAppointmentScreen({
    Key? key,
    required this.consultType,
    required this.date,
    required this.slotId,
    required this.slotTiming,
    required this.data,
  }) : super(key: key);

  @override
  State<PreviewActiveAppointmentScreen> createState() =>
      _PreviewActiveAppointmentScreenState(data);
}

class _PreviewActiveAppointmentScreenState
    extends State<PreviewActiveAppointmentScreen> {
  final ActiveAppointmentModel data;

  _PreviewActiveAppointmentScreenState(this.data);

  @override
  void initState() {
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (s) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var view = PreviewAppointmentWidgets(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Preview"),
      ),
      body: Column(
        children: [
          10.height,
          view.doctorDetailsView(data),
          5.height,
          view.patientDetailsView(data),
          5.height,
          view.slotDetailsView(widget.slotTiming, widget.date),
          10.height,
          view.bookingButtonView(onSubmit: _showConfirmDialog)
        ],
      ),
    );
  }

  _showConfirmDialog() {
    return showDialog(
        context: context,
        builder: (cxt) {
          btnColor(Color color) =>
              ElevatedButton.styleFrom(backgroundColor: color);
          return AlertDialog(
            title: Text("Appointment Confirmation"),
            content: Text("Are you sure? Do you want to book this appointment"),
            actions: [
              ElevatedButton(
                  style: btnColor(Colors.red),
                  onPressed: () {
                    finish(context);
                    setState(() {});
                  },
                  child: Text("Not Now")),
              10.width,
              ElevatedButton(
                  style: btnColor(Colors.green),
                  onPressed: () {
                    finish(context);
                    LoaderDialogView(context).showLoadingDialog();
                    _addAppointmentDetails();
                  },
                  child: Text("Sure"))
            ],
          );
        });
  }

  _addAppointmentDetails() async {
    var userId = await getStringFromLocal(userIdKey);
    ActiveAppointmentsAPIs()
        .addPatientDetailsForOnlineConsultation(
            AddPatientDetailsModel(
                doctorId: data.doctorId.toString(),
                userId: userId,
                specializationId: data.specializationId.toString(),
                patientName: data.patientName ?? "",
                patientAge: data.patientAge.toString(),
                patientGender: data.patientGender ?? "",
                patientMobile: data.patientMobileNumber ?? "",
                cityId: data.cityId.toString(),
                consultType: widget.consultType,
                slotId: widget.slotId,
                consultDate: widget.date,
                pinCode: data.pincode.toString()),
            data.bookScheduleId.toString(),
            data.transactionId ?? "")
        .then((value) {
      LoaderDialogView(context).dismissLoadingDialog();
      if (value == true) {
        PaymentSuccessfulView(
          message: "You have book a appointment again base on previous payment",
        ).launch(context, isNewTask: true);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }
}
