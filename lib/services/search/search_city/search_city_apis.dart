import 'dart:convert';

import 'package:healthcare2050/Model/search/city/searched_city_details_model.dart';
import 'package:http/http.dart' as http;
import '../../../Api/Api.dart';

class SearchCityApis{

  Future<List<SearchedCityList>> searchCityName(String searchText)async{
    var url = Uri.parse(searchInCitiesApi);
    var response = await http.post(url,body: {"CitySearch":searchText});
    if(response.statusCode == 200){
      List resData = jsonDecode(response.body);
      if(resData != []){
        return resData.map((e) => SearchedCityList.fromJson(e)).toList();
      }else{
        return List<SearchedCityList>.empty();
      }
    }else{
      return List<SearchedCityList>.empty();
    }
  }

  Future<SearchedCityDetailsModel> getCityDetails(String cityId)async{
    var url = Uri.parse(cityFacilitiesApi);
    var response = await http.post(url,body: {"CityId":cityId});
    if(response.statusCode == 200){
      var resData = jsonDecode(response.body);
      if(resData['status'] == true){
        return SearchedCityDetailsModel.fromJson(resData);
      }else{
        return SearchedCityDetailsModel();
      }
    }else{
      return SearchedCityDetailsModel();
    }
  }
}