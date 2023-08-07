import 'package:flutter/material.dart';
import 'package:healthcare2050/services/active_appointments/active_appointments_apis.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:healthcare2050/utils/styles/text_style.dart';
import 'package:healthcare2050/view/pages/active_booking/widgets/active_appointment_widgets.dart';
import 'package:healthcare2050/view/widgets/app_shimmer_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Model/active_appointments/active_appointment_model.dart';
import '../../../utils/helpers/internet_helper.dart';

class ActiveAppointmentScreen extends StatefulWidget {
  final bool showAppBar;
  final String consultType;

  const ActiveAppointmentScreen(
      {Key? key, required this.showAppBar, required this.consultType})
      : super(key: key);

  @override
  State<ActiveAppointmentScreen> createState() =>
      _ActiveAppointmentScreenState();
}

class _ActiveAppointmentScreenState extends State<ActiveAppointmentScreen> {

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (s) {});
  }

  @override
  Widget build(BuildContext context) {
    var view = AvailableAppointmentsWidgets(context: context);
    return Scaffold(
        appBar: widget.showAppBar == true
            ? AppBar(
                title: Text("Active Appointments"),
              )
            : PreferredSize(child: Container(), preferredSize: Size(0, 0)),
        body: widget.showAppBar == false
            ? _mainView(
                view,
                ActiveAppointmentsAPIs()
                    .getOnlineActiveAppointments(widget.consultType))
            : _mainView(
                view,
                ActiveAppointmentsAPIs().getOnlineActiveAppointments(widget.consultType),
              ));
  }

  _mainView(AvailableAppointmentsWidgets view,
      Future<List<ActiveAppointmentModel>>? future) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<ActiveAppointmentModel> data = snapshot.data;
          return data.isNotEmpty?ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              itemBuilder: (c, index) {
                return view.appointmentItemView(widget.showAppBar,
                    data: data[index],consultType: widget.consultType);
              },
              separatorBuilder: (c, index) {
                return 5.height;
              },
              itemCount: data.length):_noAppointmentView();
        } else {
          return _shimmerView();
        }
      },
    );
  }

  Widget _shimmerView() {
    var height = screenHeight(context);
    var width = screenWidth(context);
    return ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: 5,
        itemBuilder: (c, index) {
          return appShimmerView(height / 3.5, width - 10.0);
        });
  }

  Widget _noAppointmentView(){
    return Center(child: Text("No Appointments Available",style: AppTextStyles.boldTextStyle(txtColor: Colors.grey),),);
  }
}
