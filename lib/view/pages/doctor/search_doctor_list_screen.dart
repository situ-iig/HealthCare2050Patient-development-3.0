import 'dart:convert';
import 'package:healthcare2050/Api/Api.dart';
import 'package:healthcare2050/Model/Doctor/doctor_details_model.dart';
import 'package:healthcare2050/view/pages/doctor/widgets/doctor_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:healthcare2050/constants/constants.dart';

import '../../../utils/helpers/internet_helper.dart';


class SearchDoctorListScreen extends StatefulWidget {
  const SearchDoctorListScreen({Key? key}) : super(key: key);

  @override
  State<SearchDoctorListScreen> createState() => _SearchDoctorListScreenState();
}

class _SearchDoctorListScreenState extends State<SearchDoctorListScreen> {


  final searchController = TextEditingController();
  List<DoctorDetailsModel> showSearchList = <DoctorDetailsModel>[];

  searchListProcess() async {
    final http.Response response = await http.post(
      Uri.parse(searchDoctorApi),
      body: {"value": searchController.text.toString()},
    );

    if (response.statusCode == 200) {
      List searchBody = json.decode(response.body) ?? [];
      setState(() {
        showSearchList = searchBody.map((e) => DoctorDetailsModel.fromJson(e)).toList();
      });

    } else {
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
          backgroundColor: themColor,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextFormField(
                autofocus: true,
                controller: searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: themColor,
                  ),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : InkWell(
                          onTap: () => searchController.clear(),
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                        ),
                  hintText: 'Search doctor...',
                ),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                width: width,
                height: height * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0)),
                  color: Colors.white,
                ),
                child: showSearchList.length == 0
                    ? Center(
                        child: Text("Search a doctor by name"),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: ListView.builder(
                            itemCount: showSearchList.length,
                            itemBuilder: (context, index) {
                              return DoctorWidgets().doctorCardView(showSearchList[index], context);
                            }),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
