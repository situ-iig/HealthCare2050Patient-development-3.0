import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare2050/Model/services/service_category_model.dart';
import 'package:healthcare2050/services/service/service_apis.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:healthcare2050/utils/styles/text_style.dart';
import 'package:healthcare2050/view/pages/services/book_a_service_with_sub_category_screen.dart';
import 'package:healthcare2050/view/pages/services/widgets/all_services_widgets.dart';
import 'package:healthcare2050/view/pages/services/widgets/service_city_bottom_sheet_view.dart';
import 'package:healthcare2050/view/widgets/app_shimmer_view.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:healthcare2050/view/widgets/login_dialog_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/helpers/internet_helper.dart';

class AllServiceScreen extends StatefulWidget {
  const AllServiceScreen({Key? key}) : super(key: key);

  @override
  State<AllServiceScreen> createState() => _AllServiceScreenState();
}

class _AllServiceScreenState extends State<AllServiceScreen> {

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
        title: Text("Our Services"),
        actions: [servicesCityLogoView(onTap: _showCityBottomSheet), 10.width],
      ),
      body: FutureBuilder(
        future: ServiceApis().getServiceCategory(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<ServiceCategoryModel> data = snapshot.data;
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _itemView(data[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return 2.height;
              },
            );
          } else if (snapshot.hasError) {
            return ErrorScreen();
          } else {
            return serviceShimmerView();
          }
        },
      ),
    );
  }

  _itemView(ServiceCategoryModel data) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: secondaryBgColor,
      textColor: Colors.white,
      iconColor: Colors.white,
      leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: SvgPicture.network(
            "$categoryImagePath${data.icon}",
            color: Colors.green,
          )),
      title: Text(data.categoryName ?? "Not Available"),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child:showMoreTextView(data.description??"",moreTextColor: Colors.white,textColor: Colors.white) ,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: OutlinedButton(
                child: Text('Book Now',style: TextStyle(color: Colors.white),),
                style: OutlinedButton.styleFrom(
                  //primary: Colors.white,
                  backgroundColor: buttonColor,
                  side: BorderSide(color: Colors.green, width: 2),
                ),
                onPressed: () async {
                  if (await getBoolFromLocal(loggedInKey) == true) {
                    var subCategory = data.subcategory;
                    ShowLoginDialogInView().checkLoginStatus(
                        context,
                        BookAServiceWithSubCategoryScreen(
                          subcategory: subCategory ?? <ServiceSubcategory>[]
                        ));
                  }else{
                    Fluttertoast.showToast(msg: "You are not logged in.");
                  }
                },
              )),
        ),
      ],
    );
  }

  _showCityBottomSheet() {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (context) => ServiceCityBottomSheetView());
  }

  serviceShimmerView(){
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        itemBuilder: (context,index){
      return _shimmerItem();
    }, separatorBuilder: (context,index){
      return 10.height;
    }, itemCount: 12);
  }

  _shimmerItem(){
    return Row(
      children: [
        appShimmerView(60, 60,radius: 30),
        10.width,
        appShimmerView(20, 60.w)
      ],
    );
  }


}
