import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/Doctor/doctor_details_model.dart';
import 'package:healthcare2050/view/pages/doctor/search_doctor_list_screen.dart';
import 'package:healthcare2050/services/doctor/doctor_apis.dart';
import 'package:healthcare2050/view/pages/doctor/widgets/doctor_widgets.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/helpers/internet_helper.dart';
import '../book_appointment/online/widgets/online_doctor_widgets.dart';

class AllDoctorListScreen extends StatefulWidget {
  const AllDoctorListScreen({Key? key}) : super(key: key);

  @override
  State<AllDoctorListScreen> createState() => _AllDoctorListScreenState();
}

class _AllDoctorListScreenState extends State<AllDoctorListScreen> {

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
        title: Text("Our Doctors"),
        actions: [
          IconButton(onPressed: (){
            SearchDoctorListScreen().launch(context);
          }, icon: Icon(Icons.search))
        ],
      ),
      body: FutureBuilder(
        future: DoctorApis().getAllDoctorList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          List<DoctorDetailsModel> data = snapshot.data;
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context,index){
            return DoctorWidgets().doctorCardView(data[index],context);
          }, separatorBuilder: (context,index){
            return 5.height;
          }, itemCount: data.length);
        }else if(snapshot.hasError){
          return ErrorScreen();
        }else{
          return shimmerDoctorCardView(context);
        }
      },),
    );
  }
}
