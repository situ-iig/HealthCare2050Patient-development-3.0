import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/colors.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../Providers/CategorySubCategoryProvider.dart';
import '../../../../utils/data/server_data.dart';
import '../../services/sub_category_screen.dart';

Widget homeHeaderView(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  var width = screenWidth(context);
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 5),
    child: Container(
      height: height * 0.35,
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(.3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    //boxShadow: shadowList,
                  ),
                  margin: EdgeInsets.only(top: 30),
                ),
                Align(
                  child: Hero(
                      tag: 1,
                      child: Image.asset(
                        "assets/images/doctor_white.png",
                        height: height * 0.35,
                      )),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(.3),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              //boxShadow: shadowList,
            ),
            margin: EdgeInsets.only(
              top: 30,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/Logo/full_logo.png",width: width,height: 50,),
                  10.height,
                  Text(
                    "Bridging the Gap",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: textColor,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "We are India’s largest Transitional Care facility looking after all your healthcare needs",
                    textAlign: TextAlign.start,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: textColor,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    ),
  );
}

homeConsultationView(BuildContext context, Widget target, Color bgColor,
    String title, String subtitle, String imagePath) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: () {
      target.launch(context,pageRouteAnimation: PageRouteAnimation.Slide,duration: Duration(milliseconds: 200));
    },
    child: Card(
      elevation: 2,
      color: bgColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: bgColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
              imagePath,
              width: width/2,
              height: height * 0.2,
            ),
          ),
          Container(
            height: height * 0.08,
             width: width/2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 5, top: 5, left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  2.height,
                  Text(subtitle,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black45,
                          fontFamily: "WorkSans",
                          fontWeight: FontWeight.w400,
                          fontSize: 10)),
                  5.height
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget showOurDetailsView(String title,String image,String desc){
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "WorkSans",
                  fontWeight: FontWeight.w800),
            ),
            3.height,
            Image.asset(image),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(desc,
                  style: TextStyle(color: Colors.black),),
            )
          ],
        )),
  );
}

buildServiceView(BuildContext context){
  return Consumer<CategorySubCategoryProvider>(
    builder: (BuildContext context, value, Widget? child) {
      var catData = value.getAllData;
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: catData.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubCategoryScreen(
                          categoryName:
                          catData[index].categoryName ??
                              "Not Available",
                          categoryId: catData[index].id.toString(),
                          image: catData[index].icon ?? "",
                        )));
              },
              child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side:
                      BorderSide(width: 1, color: Colors.black38)),
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          showNetworkImageWithCached(
                              imageUrl: homeServerPath +
                                  catData[index].backgroundImage.toString(),
                              height: 40,
                              width: 40,
                              radius: 2),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              catData[index]
                                  .categoryName
                                  .toString()
                                  .split('-')
                                  .join(' '),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ))),
            ),
          );
        },
      );
    },
  );
}

homeDoctorsView(BuildContext context) {
  return HorizontalList(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ourDoctorView();
      });
}

ourDoctorView() {
  return Container(
    height: 160,
    width: 80.w,
    child: Stack(
      children: [
        Positioned(
            left: 0,
            bottom: 0,
            top: 0,
            child: Container(
              height: 160,
              width: 60.w,
              decoration: boxDecorationRoundedWithShadow(20,
                  backgroundColor: secondaryBgColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Doctor Name",style: boldTextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis),
                  Text("Doctor Qualifications this is only testing here",style: secondaryTextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  Text("Doctor Qualifications this is only testing here",style: secondaryTextStyle(color: Colors.white,size: 10),maxLines: 1,overflow: TextOverflow.ellipsis,),
                ],
              ).paddingOnly(top: 20,right: 60,left: 12,bottom: 20),
            )),
        Positioned(
            right: 6.w,
            bottom: 20,
            top: 20,
            child: Container(
                width: 100,
                child: showNetworkImageWithCached(imageUrl: "https://tse2.mm.bing.net/th?id=OIP.7ZuYwrIdy7FFk5IXAI7bcAHaGl&pid=Api&P=0", height: 100, width: 100, radius: 20),
                decoration: boxDecorationRoundedWithShadow(20,
                    backgroundColor: Colors.green)))
      ],
    ),
  );

}


