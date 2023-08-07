import 'package:flutter/material.dart';
import 'package:healthcare2050/services/appointments/offline_appointment_apis.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/view/pages/book_appointment/offline/appointment_doctor_details_screen.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../Model/appointments/doctor_appointment_model.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/helpers/internet_helper.dart';
import '../../../widgets/app_shimmer_view.dart';

class AppointmentDoctorScreen extends StatefulWidget {
  final String cityId;
  final String specialId;

  const AppointmentDoctorScreen(
      {Key? key, required this.cityId, required this.specialId})
      : super(key: key);

  @override
  State<AppointmentDoctorScreen> createState() =>
      _AppointmentDoctorScreenState();
}

class _AppointmentDoctorScreenState extends State<AppointmentDoctorScreen> {

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context).checkConnectivityRealTime(callBack: (status){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Doctors"),
      ),
      body: FutureBuilder(
        future: OfflineAppointmentApi()
            .getDoctorBySpecialization(widget.cityId, widget.specialId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<DoctorAppointmentModel> data = snapshot.data;
            return data.isNotEmpty?doctorGridListView(data):_noDoctorView();
          } else if(snapshot.hasError){
            return ErrorScreen();
          }
          else {
            return showShimmerView();
          }
        },
      ),
    );
  }

  doctorGridListView(List<DoctorAppointmentModel> data) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2,childAspectRatio: 0.9),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          String doctorName =
              data[index].fullName.toString().split('-').join(' ');
          doctorName.split('-').join('');
          return InkWell(
            onTap: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AppointmentDoctorDetailsScreen(doctorData: data[index],cityId: widget.cityId,)));
            },
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Column(
                children: [
                  doctorImageView("$doctorImagePath${data[index].image}"),
                  5.height,
                  Text(
                    doctorName,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: themColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  2.height,
                  Text(
                    data[index].education ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: themColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  ),
                  2.height,
                  Text(
                    data[index].designation ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: themColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  ),
                ],
              ).paddingAll(5),
            ),
          );
        });
  }

  Widget doctorImageView(String imageUrl){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(width: 1,color: iconColor)
      ),
      child: showNetworkImageWithCached(imageUrl: imageUrl, height: 100, width: 100, radius: 50),
    );
  }

  _noDoctorView(){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Currently, Doctors are not available.",style: boldTextStyle(color: textColor,size: 20),),
          10.height,
          Text("Doctors will be available soon.",style: TextStyle(color: textColor,fontSize: 12),)
        ],
      ),
    );
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
          appShimmerView(100, 100, radius: 50),
          5.height,
          appShimmerView(20, 120),
          appShimmerView(16, 100),
          appShimmerView(12, 120),
        ],
      ),
    );
  }
}


