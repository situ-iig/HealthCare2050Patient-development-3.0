import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/search/city/searched_city_details_model.dart';
import 'package:healthcare2050/Model/services/service_city_model.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../services/service/service_apis.dart';
import '../../../widgets/loader_dialog_view.dart';
import '../../searches/search_city_details_screen.dart';

class ServiceCityBottomSheetView extends StatelessWidget {
  const ServiceCityBottomSheetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: ServiceApis().getAllCityOfService(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          List<ServiceCityModel> data  = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return _expansionTileItemView(data[index],context);
            },
          );
        }else if(snapshot.hasError){
          return ErrorScreen();
        }
        else{
          return ScreenLoadingView();
        }
      },),
    );
  }

  _expansionTileItemView(ServiceCityModel cityData,BuildContext context){
    return Column(
      children: [
        ListTile(
          onTap: (){
            finish(context);
            SearchCityDetailsScreen(cityId: cityData.id.toString(), cityName: cityData.cityName.toString(),).launch(context);
          },
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
              )
          ),
          trailing: Icon(Icons.keyboard_arrow_right,color: iconColor,),
          leading: showNetworkImageWithCached(imageUrl: "$cityImagePath${cityData.icon}", height: 40, width: 40, radius: 20),
          title: Text(cityData.cityName??"Not Available",style: TextStyle(color: textColor),),
        ),
        Divider(thickness: 1,color: iconColor,height: 2,)
      ],
    );
  }
}
