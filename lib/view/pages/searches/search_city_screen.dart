import 'package:healthcare2050/services/search/search_city/search_city_apis.dart';
import 'package:healthcare2050/view/pages/searches/search_city_details_screen.dart';
import 'package:healthcare2050/view/pages/searches/widgets/search_item_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/search/city/searched_city_details_model.dart';
import '../../../utils/helpers/internet_helper.dart';


class SearchCityScreen extends StatefulWidget {
  const SearchCityScreen({Key? key}) : super(key: key);

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {

  final searchController = TextEditingController();
  List<SearchedCityList> cityList = <SearchedCityList>[];

  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (status) {});
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Your City'),
        bottom: PreferredSize(
            child: searchTextField(searchController,"Search your city name..",
              onChanged: (text)async{
              setState((){
              });
              cityList = await SearchCityApis().searchCityName(text);
              },
            ),
            preferredSize: Size(90.w, 6.h)),
      ),
      body: cityList.length == 0
          ? Container(
          color: Colors.white,
          width: width,
          height: height,
          child: Center(
              child: Text("Search a your city and book a service online",style: TextStyle(color: Colors.grey),)))
          : SizedBox(
        height: height,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          itemCount: cityList.length,
          itemBuilder: (context, index) {
            return searchItemView(cityList[index].cityName.toString(),onTap: (){
              SearchCityDetailsScreen(cityId:cityList[index].id.toString(), cityName: cityList[index].cityName.toString() ,).launch(context);
            });
          }, separatorBuilder: (BuildContext context, int index) {
          return 10.height;
        },),
      )
    );
  }
}
