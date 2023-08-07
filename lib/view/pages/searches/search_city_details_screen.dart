import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/search/city/searched_city_details_model.dart';
import 'package:healthcare2050/services/search/search_city/search_city_apis.dart';
import 'package:healthcare2050/view/pages/searches/widgets/city_details_widgets.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/helpers/internet_helper.dart';

class SearchCityDetailsScreen extends StatefulWidget {
  final String cityId;
  final String cityName;
  const SearchCityDetailsScreen({Key? key, required this.cityId, required this.cityName}) : super(key: key);

  @override
  State<SearchCityDetailsScreen> createState() => _SearchCityDetailsScreenState();
}

class _SearchCityDetailsScreenState extends State<SearchCityDetailsScreen> {

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
        title: Text(widget.cityName),
      ),
      body: FutureBuilder(
        future: SearchCityApis().getCityDetails(widget.cityId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          SearchedCityDetailsModel data = snapshot.data;
          return _detailsView(data);
        }else if(snapshot.hasError){
          return ErrorScreen();
        }else{
          return ScreenLoadingView();
        }
      },),
    );
  }

  _detailsView(SearchedCityDetailsModel data){
    return ListView(
      padding: EdgeInsets.only(bottom: 20),
      children: [
        CityDetailsWidgets.topImageView(data.backgroundImage??""),
        10.height,
        CityDetailsWidgets.overViewText(data.cityName??"Not Available",).paddingSymmetric(horizontal: 10),
        10.height,
        CityDetailsWidgets.showContactDetailsView(data.contact??SearchedCityContactDetails()),
        Card(
          elevation: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Our Service",style: boldTextStyle(size: 16),).paddingSymmetric(horizontal: 10),
              Divider(color: iconColor,thickness: 1,),
              CityDetailsWidgets().showServiceListView(data.sevicename??<SearchedServiceNameList>[], context),
            ],
          ).paddingSymmetric(vertical: 10)
        ),
        10.height,
        Card(
            elevation: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Our Doctors",style: boldTextStyle(size: 16),).paddingSymmetric(horizontal: 10),
                Divider(color: iconColor,thickness: 1,),
                CityDetailsWidgets().showDoctorListView(data.doctorDetail??<SearchedDoctorDetailsList>[], context),
              ],
            ).paddingSymmetric(vertical: 10)
        ),
        10.height,
        Text("Our City",style: boldTextStyle(color: textColor),).paddingSymmetric(horizontal: 10),
        CityDetailsWidgets().showCityListView(data.allcityFetch??<SearchedCityList>[], context)
      ],
    );
  }
}
