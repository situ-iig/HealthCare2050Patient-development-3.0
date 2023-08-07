import 'package:flutter/material.dart';
import 'package:healthcare2050/view/pages/services/sub_category_screen.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/utils/styles/text_style.dart';
import 'package:healthcare2050/view/pages/searches/search_city_details_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../Model/search/city/searched_city_details_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants/basic_strings.dart';

class CityDetailsWidgets {
  static topImageView(String image) {
    var height = 25.h;
    return SizedBox(
      height: height,
      child: showNetworkImageWithCached(
          imageUrl: "$cityImagePath$image",
          height: height,
          width: 100.w,
          radius: 2),
    );
  }

  static Widget overViewText(String cityName) {
    return showMoreTextView(getCityOverViewText(cityName),
        moreTextColor: Colors.black);
  }

  static Widget showContactDetailsView(SearchedCityContactDetails data) {
    return SizedBox(
     // height: 110,
      width: 90.w,
      child: Card(
        color: secondaryBgColor,
        child: Column(
          children: [
            5.height,
            Text(
              'Contact Us',
              style: boldTextStyle(color: Colors.white, size: 18),
            ),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Text(
              "${data.address ?? ''}${data.address1 ?? ''}${data.address2 ?? ''}, ${data.cityName ?? ''}, ${data.stateName ?? ''}, ${data.pincode ?? ''}",
              style: TextStyle(color: Colors.white),
            ).paddingSymmetric(horizontal: 10),
            2.height,
            Row(
              children: [
                Text(
                  "Contact No : ",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "${data.contact_no??"Not Available"}",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                )
              ],
            ).paddingSymmetric(horizontal: 10),
            5.height,
          ],
        ),
      ),
    );
  }

  Widget showServiceListView(
      List<SearchedServiceNameList> data, BuildContext context) {
    return SizedBox(
      height: 37.h,
      width: 100.w,
      child: data.isNotEmpty
          ? ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _serviceItemView(data[index], context);
              },
              separatorBuilder: (context, index) {
                return 10.width;
              },
              itemCount: data.length)
          : _noDataAvailable("Services"),
    );
  }

  _serviceItemView(SearchedServiceNameList data, BuildContext context) {
    return SizedBox(
      width: 50.w,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(width: 1, color: Colors.green)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: showSVGImage(
                    imagePath: "$categoryImagePath${data.icon}",
                    height: 90,
                    width: 90,
                    radius: 45,
                    fit: BoxFit.cover,
                    imageColor: Colors.green),
              ),
            ),
            Text(
              data.categoryName ?? "Not Found",
              style: boldTextStyle(color: Colors.black),
            ),
            2.height,
            Text(
              data.description ?? "No Data",
              style: TextStyle(color: Colors.black, fontSize: 14),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ).paddingSymmetric(horizontal: 10),
            20.height,
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: buttonColor, fixedSize: Size(40.w, 5.h)),
                onPressed: () {
                  SubCategoryScreen(
                    categoryId: data.id.toString(),
                    image: data.icon ?? "",
                    categoryName: data.categoryName ?? "Not Available",
                  ).launch(context);
                },
                child: Text("View Details"))
          ],
        ),
      ),
    );
  }

  Widget showDoctorListView(
      List<SearchedDoctorDetailsList> data, BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: 100.w,
      child: data.isNotEmpty
          ? ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _doctorDetailsView(data[index]);
              },
              separatorBuilder: (context, index) {
                return 10.width;
              },
              itemCount: data.length)
          : _noDataAvailable("Doctors"),
    );
  }

  _doctorDetailsView(SearchedDoctorDetailsList data) {
    return SizedBox(
      width: 50.w,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              showNetworkImageWithCached(
                  imageUrl: "$doctorImagePath${data.image}",
                  height: 150,
                  width: 50.w,
                  radius: 8),
              5.height,
              Text(
                data.fullName ?? 'Not Available',
                style: boldTextStyle(color: textColor, size: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                data.education ?? "Not Available",
                style: secondaryTextStyle(color: textColor, size: 12),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showCityListView(List<SearchedCityList> data, BuildContext context) {
    return SizedBox(
      height: 60,
      width: 100.w,
      child: data.isNotEmpty
          ? ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 5),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _cityItemView(data[index], context);
              },
              separatorBuilder: (context, index) {
                return 10.width;
              },
              itemCount: data.length)
          : _noDataAvailable("Cities"),
    );
  }

  _cityItemView(SearchedCityList data, BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50.w,
      child: InkWell(
        onTap: () {
          SearchCityDetailsScreen(
                  cityId: data.id.toString(), cityName: data.cityName ?? "")
              .launch(context);
        },
        child: Card(
          color: secondaryBgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.cityName ?? "Not Available",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              )
            ],
          ).paddingSymmetric(horizontal: 10),
        ),
      ),
    );
  }

  _noDataAvailable(String type) {
    return Center(
      child: Text(
        "No $type Available Now",
        style: boldTextStyle(color: Colors.grey),
      ),
    );
  }
}
