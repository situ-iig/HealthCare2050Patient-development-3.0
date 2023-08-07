import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/active_appointments/active_appointment_model.dart';
import 'package:healthcare2050/services/active_appointments/active_appointments_apis.dart';
import 'package:healthcare2050/utils/shapes/app_shapes.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:healthcare2050/utils/styles/text_style.dart';
import 'package:healthcare2050/view/pages/book_appointment/online/widgets/online_specialization_widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/appointments/online/online_specialization_model.dart';
import '../../../../services/appointments/online_appointment_apis.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/helpers/internet_helper.dart';
import '../../../widgets/app_shimmer_view.dart';
import '../../../widgets/loader_dialog_view.dart';
import '../../active_booking/widgets/active_appointments_tab_view.dart';
import 'online_doctor_screen.dart';

class OnlineSpecializationScreen extends StatefulWidget {
  const OnlineSpecializationScreen({Key? key}) : super(key: key);

  @override
  State<OnlineSpecializationScreen> createState() =>
      _OnlineSpecializationScreenState();
}

class _OnlineSpecializationScreenState
    extends State<OnlineSpecializationScreen> {
  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (a) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Specialization"),
      ),
      body: FutureBuilder(
        future: Future.wait([
          OnlineAppointmentsApis().getOnlineSpecializations(),
          ActiveAppointmentsAPIs().getOnlineActiveAppointments("1"),
          ActiveAppointmentsAPIs().getOnlineActiveAppointments("2")
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<OnlineSpecializationData> data = snapshot.data[0];
            List<ActiveAppointmentModel> appointments = snapshot.data[1];
            List<ActiveAppointmentModel> telephoneData = snapshot.data[2];
            var appointmentLength = appointments.length + telephoneData.length;
            return Column(
              children: [
                appointmentLength != 0
                    ? _availableAppointmentCardView(appointmentLength)
                    : Container(),
                Expanded(child: _specializationItemView(data))
              ],
            );
          } else if (snapshot.hasError) {
            return ErrorScreen();
          } else {
            return _shimmerView();
          }
        },
      ),
    );
  }

  Widget _specializationItemView(List<OnlineSpecializationData> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Select a specialization for consultation.",
          style: TextStyle(fontSize: 16, color: textColor),
        ).paddingSymmetric(horizontal: 10),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.transparent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                    onTap: () {
                      OnlineDoctorScreen(
                        specializationData: data[index],
                      ).launch(context,
                          pageRouteAnimation: PageRouteAnimation.Scale,
                          duration: Duration(milliseconds: 200));
                    },
                    child: onlineSpecializationGridItemView(
                        data[index].icon ?? "",
                        data[index].sepcializationName ?? "")),
              );
            })
      ],
    );
  }

  Widget _availableAppointmentCardView(int count) {
    return Card(
      elevation: 10,
      shape: circularBorderShape(borderRadius: 6, borderColor: Colors.green),
      child: ListTile(
        onTap: () {
          ActiveAppointmentsTabView().launch(context);
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

  _shimmerView() {
    var height = screenHeight(context);
    var width = screenWidth(context);
    return Column(
      children: [
        10.height,
        appShimmerView(height / 10, width - 20.0),
        (height / 6).height,
        appShimmerView(20, 80.w),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 9,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: appShimmerView(120, 120),
              );
            })
      ],
    );
  }
}
