import 'package:flutter/material.dart';
import 'package:healthcare2050/Model/services/service_sub_category_details_model.dart';
import 'package:healthcare2050/services/service/service_apis.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';
import 'package:healthcare2050/utils/sizes/app_sizes.dart';
import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/utils/styles/text_style.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:healthcare2050/constants/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/data/server_data.dart';
import 'book_a_service_screen.dart';
import '../../widgets/login_dialog_view.dart';

class SubCategoryDetailsScreen extends StatefulWidget {
  final String subCategoryId;

  const SubCategoryDetailsScreen({Key? key, required this.subCategoryId})
      : super(key: key);

  @override
  _SubCategoryDetailsScreenState createState() =>
      _SubCategoryDetailsScreenState();
}

class _SubCategoryDetailsScreenState extends State<SubCategoryDetailsScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (a) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Service Details",
        ),
      ),
      body: FutureBuilder(
        future:
            ServiceApis().getServiceSubCategoryDetails(widget.subCategoryId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            ServiceSubCategoryData data = snapshot.data;
            return Stack(
              children: [
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  top: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: Container(
                      child:
                          ListView(physics: BouncingScrollPhysics(), children: [
                        _topView(data.subBackgroundImage ?? "",
                            data.subcategoryName ?? "Not Available"),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              showMoreTextView(
                                  data.description ??
                                      "No description available now",
                                  textColor: Colors.white)
                            ],
                          ),
                        ),
                        10.height,
                        Text(
                          "Our Content",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Text(data.subcategoryMobileContent ??
                            "Content not available now"),
                        20.height
                      ]),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 10,
                    right: 10,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themColor, // Background color
                        ),
                        onPressed: () {
                          ShowLoginDialogInView().checkLoginStatus(
                              context,
                              BookAServiceScreen(
                                subCategoryName:
                                    data.subcategoryName ?? "No Data",
                                subCategoryId: data.id.toString(),
                              ));
                        },
                        icon: Icon(
                          Icons.medical_services,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        label: Text(
                          'Book A Service',
                          style: TextStyle(color: Colors.white),
                        )))
              ],
            );
          } else if (snapshot.hasError) {
            return ErrorScreen();
          } else {
            return ScreenLoadingView();
          }
        },
      ),
    );
  }

  _topView(String image, String title) {
    var width = screenWidth(context);
    return Container(
      child: Stack(
        children: [
          showNetworkImageWithCached(
              imageUrl: "$subCategoryBackgroundImagePath$image",
              height: 150,
              width: width,
              radius: 4),
          Positioned(
              bottom: 0,
              child: Container(
                height: 40,
                width: width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(colors: [
                      secondaryBgColor.withOpacity(.5),
                      secondaryBgColor.withOpacity(.4),
                      secondaryBgColor.withOpacity(.1),
                    ])),
                child: Text(title.split("-").join(" "),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "WorkSans",
                        fontSize: 18)),
              ))
        ],
      ),
    );
  }
}
