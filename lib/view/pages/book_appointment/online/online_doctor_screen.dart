import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/book_appointment/online/widgets/online_doctor_widgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../Model/appointments/online/online_doctor_model.dart';
import '../../../../Model/appointments/online/online_specialization_model.dart';
import '../../../../services/appointments/online_appointment_apis.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/helpers/internet_helper.dart';
import '../../../widgets/loader_dialog_view.dart';

class OnlineDoctorScreen extends StatefulWidget {
  final OnlineSpecializationData specializationData;
  const OnlineDoctorScreen({Key? key, required this.specializationData}) : super(key: key);

  @override
  State<OnlineDoctorScreen> createState() => _OnlineDoctorScreenState();
}

class _OnlineDoctorScreenState extends State<OnlineDoctorScreen> {

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context).checkConnectivityRealTime(callBack: (a){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Doctors"),
      ),
      body: RefreshIndicator(child: FutureBuilder(
        future: OnlineAppointmentsApis().getOnlineDoctors(widget.specializationData.specializationId.toString()),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            List<OnlineDoctorsModel> data = snapshot.data;
            return data.isNotEmpty?ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                itemBuilder: (context,index){
                  return doctorCardView(data[index],context,widget.specializationData.specializationId.toString());
                }, separatorBuilder: (context,index){
              return 10.height;
            }, itemCount: data.length):noDoctorAvailableView();
          }else if(snapshot.hasError){
            return ErrorScreen();
          }else{
            return shimmerDoctorCardView(context);
          }
        },), onRefresh: (){
        return OnlineAppointmentsApis().getOnlineDoctors(widget.specializationData.specializationId.toString());
      },color: iconColor,),
    );
  }
}
