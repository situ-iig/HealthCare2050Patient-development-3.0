import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:healthcare2050/view/pages/services/sub_category_details_screen.dart';
import 'package:healthcare2050/services/service/service_apis.dart';
import 'package:healthcare2050/utils/data/server_data.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';

import 'package:healthcare2050/utils/styles/image_style.dart';
import 'package:healthcare2050/view/widgets/app_shimmer_view.dart';
import 'package:healthcare2050/view/widgets/loader_dialog_view.dart';
import 'package:healthcare2050/constants/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Model/services/service_sub_category_model.dart';

class SubCategoryScreen extends StatefulWidget {
  final String categoryId;
  final String image;
  final String categoryName;

  const SubCategoryScreen(
      {Key? key,
      required this.categoryId,
      required this.image,
      required this.categoryName})
      : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  void initState() {
    super.initState();
    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (s) {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        toolbarHeight: 50,
        elevation: 5,
        backgroundColor: themColor,
        iconTheme: IconThemeData(color: themColor),
        title: const Text("Our Services",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontFamily: 'WorkSans')),
      ),
      body: FutureBuilder(
        future: ServiceApis().getServiceSubCategory(widget.categoryId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<ServiceSubCategoryModel> data = snapshot.data;
            return buildBody(data);
          } else if (snapshot.hasError) {
            return ErrorScreen();
          } else {
            return _shimmerItemView(height);
          }
        },
      ),
    );
  }

  buildBody(List<ServiceSubCategoryModel> data) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          showSVGImage(
              imagePath: "$categoryImagePath${widget.image}",
              height: 50,
              width: 50,
              radius: 4,
              fit: BoxFit.cover,
              imageColor: Colors.green),
          10.width,
          Text(widget.categoryName.toString().split('-').join(' '),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontFamily: "WorkSans",
                  fontSize: 18)),
        ]),
        10.height,
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            itemCount: data.length,
            itemBuilder: (context, index) {
              var subCategoryData = data;
              return ListTile(
                tileColor: Colors.white,
                title: InkWell(
                  onTap: () {
                    SubCategoryDetailsScreen(
                      subCategoryId: data[index].id.toString(),
                    ).launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade,duration: Duration(microseconds: 300));
                  },
                  child: Container(
                    height: height * 0.25,
                    child: Card(
                      // shadowColor: themColor,
                      color: setColor(index),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: showNetworkImageWithCached(
                                fit: BoxFit.contain,
                                imageUrl:
                                    "$subCategoryImagePath${subCategoryData[index].icon}",
                                height: 50,
                                width: 40,
                                radius: 4),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 2, right: 2),
                            child: Container(
                                child: Text(
                              subCategoryData[index].subcategoryName?.split("-").join(" ") ??
                                  "Not Available",
                              style: TextStyle(
                                  color: themColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto"),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ))
      ],
    );
  }

  _shimmerItemView(double height) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          appShimmerView(60, 60, radius: 30),
          10.width,
          appShimmerView(20, 150),
        ]),
        10.height,
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: appShimmerView(height * 0.25, 150, radius: 20))
                  .paddingAll(10);
            },
          ),
        ))
      ],
    );
  }

  setColor(int index) {
    return index.isEven ? Colors.white : Colors.grey;
  }
}
