import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/active_appointments/active_appointment_model.dart';
import 'package:healthcare2050/Model/appointments/city_appointment_model.dart';
import 'package:healthcare2050/services/active_appointments/active_appointments_apis.dart';
import 'package:healthcare2050/services/appointments/offline_appointment_apis.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:healthcare2050/view/pages/book_appointment/offline/widgets/offline_appointment_widget.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/shapes/app_shapes.dart';
import '../../../../utils/styles/text_style.dart';
import '../../active_booking/active_appointments_screen.dart';

class OfflineAppointmentScreen extends StatefulWidget {
  const OfflineAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<OfflineAppointmentScreen> createState() =>
      _OfflineAppointmentScreenState();
}

class _OfflineAppointmentScreenState extends State<OfflineAppointmentScreen> {
  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  Widget build(BuildContext context) {
    var height = screenHeight(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment City"),
      ),
      body: FutureBuilder(
        future: Future.wait([OfflineAppointmentApi().getAllCityData(),ActiveAppointmentsAPIs().getOnlineActiveAppointments("3")]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Cityname> data = snapshot.data[0];
            List<ActiveAppointmentModel>  appointment = snapshot.data[1];
            return Column(
              children: [
                appointment.isNotEmpty?_availableAppointmentCardView(appointment.length):Container(),
                (height / 7).height,
                cityCarouselSliderView(data)
              ],
            );
          } else if (snapshot.hasError) {
            return ErrorScreen();
          } else {
            return ScreenLoadingView();
          }
        },
      ).center(),
    );
  }

  Widget _availableAppointmentCardView(int count) {
    return Card(
      elevation: 10,
      shape: circularBorderShape(borderRadius: 6, borderColor: Colors.green),
      child: ListTile(
        onTap: () {
          ActiveAppointmentScreen(
            showAppBar: true,
            consultType: '3',
          ).launch(context);
        },
        tileColor: Colors.white,
        leading: CircleAvatar(
          backgroundColor: secondaryBgColor,
          child: Text(
            count.toString(),
            style: AppTextStyles.boldTextStyle(txtColor: Colors.white),
          ),
        ),
        shape: circularBorderShape(borderRadius: 6),
        title: Text(
          "Active Appointments",
          style: AppTextStyles.boldTextStyle(size: 16),
        ),
        subtitle: Text(
          "You have some free followups within 7 days.",
          style: AppTextStyles.normalTextStyle(),
        ),
      ).paddingSymmetric(vertical: 5),
    ).paddingAll(6);
  }
}
