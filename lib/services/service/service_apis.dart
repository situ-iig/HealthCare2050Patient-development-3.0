import 'dart:convert';

import 'package:healthcare2050/Model/services/service_sub_category_details_model.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';

import '../../Api/Api.dart';
import '../../Model/BookCodeModel/BookCodeModel.dart';
import '../../Model/services/service_category_model.dart';
import '../../Model/services/service_city_model.dart';
import 'package:http/http.dart' as http;

import '../../Model/services/service_sub_category_model.dart';
import '../../utils/data/shared_preference.dart';

class ServiceApis {
  Future<List<ServiceCityModel>> getAllCityOfService() async {
    var url = Uri.parse(service_city_api);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List resData = jsonDecode(response.body);
      if (resData != []) {
        return resData.map((e) => ServiceCityModel.fromJson(e)).toList();
      } else {
        return List<ServiceCityModel>.empty();
      }
    } else {
      return List<ServiceCityModel>.empty();
    }
  }

  Future<List<ServiceCategoryModel>> getServiceCategory() async {
    var response = await http.get(
      Uri.parse(categoryApi),
    );
    if (response.statusCode == 200) {
      List categoryItems = json.decode(response.body);
      if (categoryItems != []) {
        return categoryItems
            .map((e) => ServiceCategoryModel.fromJson(e))
            .toList();
      } else {
        return List<ServiceCategoryModel>.empty();
      }
    } else {
      return List<ServiceCategoryModel>.empty();
    }
  }

  Future<List<ServiceSubCategoryModel>> getServiceSubCategory(
      String categoryId) async {
    var response = await http
        .post(Uri.parse(getSubCategoryApi), body: {"CategoryId": categoryId});
    if (response.statusCode == 200) {
      var categoryItems = json.decode(response.body);
      if (categoryItems['CategoryData'] != []) {
        List data = categoryItems['CategoryData'];
        return data.map((e) => ServiceSubCategoryModel.fromJson(e)).toList();
      } else {
        return List<ServiceSubCategoryModel>.empty();
      }
    } else {
      return List<ServiceSubCategoryModel>.empty();
    }
  }

  Future<ServiceSubCategoryData> getServiceSubCategoryDetails(
      String subCategoryId) async {
    var url = Uri.parse(subCategoryDetailsApi);
    var response = await http.post(url, body: {"SubcategoryId": subCategoryId});
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if (resData['status'] == true) {
        return ServiceSubCategoryData.fromJson(resData['SubactegoryListing']);
      } else {
        return ServiceSubCategoryData();
      }
    } else {
      return ServiceSubCategoryData();
    }
  }

  Future<BookCodeModel> getBookingCode(String subCatId) async {
    String bookCode_url = bookCodeApi;
    final http.Response response = await http.post(
      Uri.parse(bookCode_url),
      body: {"subcategoryId": subCatId},
    );

    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if (resData['status'] == true) {
        return BookCodeModel.fromJson(resData);
      } else {
        return BookCodeModel(status: false);
      }
    } else {
      return BookCodeModel(status: false);
    }
  }

  Future<bool> bookAService({
    String? bookCode,
    String? cityId,
    String? subCategoryId,
    String? name,
    String? mobile,
    String? emailAddress,
  }) async {
    var userId = await getStringFromLocal(userIdKey);
    var url = Uri.parse(bookAServiceApi);
    final http.Response response = await http.post(
      url,
      body: {
        "bcode": bookCode,
        'bcity': cityId,
        'stype': subCategoryId,
        'bfullname': name,
        'bphone': mobile,
        'bmail': emailAddress,
        'CreatedBy': userId,
      },
    );
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if (resData['status'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
