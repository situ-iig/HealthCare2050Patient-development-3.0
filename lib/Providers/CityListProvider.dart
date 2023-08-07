import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:healthcare2050/Api/Api.dart';
import 'package:http/http.dart' as http;

class CityListProvider with ChangeNotifier {
  List cityList = [];
  bool isloading = true;

  Future fetchCity() async {
    var cityUrl = service_city_api;
    var response = await http.get(
      Uri.parse(cityUrl),
      headers: <String, String>{},
    );
    // print(response.body);
    if (response.statusCode == 200) {
      isloading = false;
      var cityItems = json.decode(response.body);
      cityList = cityItems;

      notifyListeners();

      print(
          "City lIST//////////////////////////////////////////////////////////////////////////////////////////");
      print(cityList.toString());
    } else {
      cityList = [];
      isloading = true;
      notifyListeners();
    }
  }
}
