import 'dart:convert';
import 'package:healthcare2050/Api/Api.dart';
import 'package:healthcare2050/view/pages/services/sub_category_details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/helpers/internet_helper.dart';
import 'widgets/search_item_widgets.dart';

class SearchServiceScreen extends StatefulWidget {
  const SearchServiceScreen({Key? key}) : super(key: key);

  @override
  State<SearchServiceScreen> createState() =>
      _SearchServiceScreenState();
}

class _SearchServiceScreenState extends State<SearchServiceScreen> {
  final searchController = TextEditingController();

  List showSearchList = [];

   searchListProcess() async {
    final http.Response response = await http.post(
      Uri.parse(searchServiceApi),
      body: {"search": searchController.text.toString()},
    );

    if (response.statusCode == 200) {
      final searchBody = json.decode(response.body) ?? [];
      setState(() {
        showSearchList = searchBody;
      });

      print('Search list');
      print(showSearchList);

    } else {
      showSearchList = [];

      throw Exception('Failed to create search body album.');
    }
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchListProcess);
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
          title: Text('Search Services'),
          bottom: PreferredSize(
              child: searchTextField(searchController, "Search a service"),
              preferredSize: Size(90.w, 6.h)),
        ),
        body: showSearchList.length == 0
            ? Container(
                color: Colors.white,
                width: width,
                height: height,
                child: Center(child: Text("Search a service and book it online",style: TextStyle(color: Colors.grey),)))
            : SizedBox(
                height: height,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: showSearchList.length,
                  itemBuilder: (context, index) {
                    return searchItemView(
                        showSearchList[index]['SubcategoryName'].toString(),
                        onTap: () {
                      SubCategoryDetailsScreen(
                              subCategoryId:
                                  showSearchList[index]['Id'].toString())
                          .launch(context);
                    });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return 10.height;
                  },
                ),
              ));
  }
}
