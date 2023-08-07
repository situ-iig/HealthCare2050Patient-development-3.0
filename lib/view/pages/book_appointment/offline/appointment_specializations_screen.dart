import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/appointments/specialist_appointment_model.dart';
import 'package:healthcare2050/services/appointments/offline_appointment_apis.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/view/pages/book_appointment/offline/appointment_doctor_screen.dart';
import 'package:healthcare2050/view/widgets/app_shimmer_view.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../utils/helpers/internet_helper.dart';

class AppointmentSpecializationScreen extends StatefulWidget {
  final String cityId;

  const AppointmentSpecializationScreen({Key? key, required this.cityId})
      : super(key: key);

  @override
  State<AppointmentSpecializationScreen> createState() =>
      _AppointmentSpecializationScreenState();
}

class _AppointmentSpecializationScreenState
    extends State<AppointmentSpecializationScreen> {
  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Specialization"),
      ),
      body: FutureBuilder(
        future: OfflineAppointmentApi().getSpecialistByCityName(widget.cityId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<SpecializationName> data = snapshot.data;
            return data.isEmpty
                ? _noSpecializationView()
                : specialistLIstView(data);
          } else if (snapshot.hasError) {
            return ErrorScreen();
          } else {
            return showShimmerView();
          }
        },
      ),
    );
  }

  specialistLIstView(List<SpecializationName> data) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              AppointmentDoctorScreen(
                      cityId: widget.cityId,
                      specialId: data[index].specializationId.toString())
                  .launch(context,
                      pageRouteAnimation: PageRouteAnimation.Slide);
            },
            child: Card(
              elevation: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showNetworkImageWithCached(
                      imageUrl: "$onlineSpecializationPath${data[index].icon}",
                      height: 60,
                      width: 60,
                      radius: 8),
                  10.height,
                  Text(
                    data[index].sepcializationName ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textColor, fontSize: 14),
                  )
                ],
              ),
            ),
          );
        });
  }

  _noSpecializationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sorry, No specialization available",
          style: boldTextStyle(color: textColor, size: 20),
        ),
        10.height,
        Text(
          "Book offline appointment from anywhere.",
          style: secondaryTextStyle(color: textColor, size: 12),
        ),
      ],
    ).paddingSymmetric(horizontal: 10);
  }


  Widget showShimmerView() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return _shimmerItemView();
        });
  }

  Widget _shimmerItemView() {
    return Card(
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appShimmerView(90, 90, radius: 45),
          10.height,
          appShimmerView(20, 100),
        ],
      ),
    );
  }
}
