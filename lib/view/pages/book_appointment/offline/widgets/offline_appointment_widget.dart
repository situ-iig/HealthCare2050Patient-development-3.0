import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/view/pages/book_appointment/offline/appointment_specializations_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Model/appointments/city_appointment_model.dart';
import '../../../../../utils/data/server_data.dart';

cityCarouselSliderView(List<Cityname> cityList) {
  int _currentPosition = 0;
  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cityDescriptionView(),
          40.height,
          CarouselSlider(
              carouselController: CarouselController(),
              options: CarouselOptions(
                  height: 40.h,
                  aspectRatio: 16 / 9,
                  initialPage: 0,
                  viewportFraction: .7,
                  pauseAutoPlayOnTouch: true,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  autoPlayAnimationDuration: const Duration(seconds: 5),
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentPosition = index;
                    });
                  }),
              items: cityList.map((itemIndex) {
                return citySliderView(itemIndex, context);
              }).toList()),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: cityList.map((url) {
              int index = cityList.indexOf(url);
              return Container(
                width: 15.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPosition == index
                      ? iconColor
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          )
        ],
      );
    },
  );
}

Widget citySliderView(Cityname data, BuildContext context) {
  return Builder(
      builder: (context) => Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: secondaryBgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(40)),
              border: Border.all(
                  color: Colors.grey, width: 2.0, style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                showNetworkImageWithCached(
                    imageUrl: "$cityImagePath${data.icon}",
                    height: 140,
                    width: 140,
                    radius: 20,
                    fit: BoxFit.contain),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  data.cityName ?? "".toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ).onTap(() {
            AppointmentSpecializationScreen(cityId: data.id.toString()).launch(
                context,
                pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
          }));
}

Widget showDialogA() {
  return AlertDialog(
    title: Text("Nothing"),
  );
}

Text cityDescriptionView() {
  return Text(
    "Please select your city for offline appointments",
    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
  );
}
