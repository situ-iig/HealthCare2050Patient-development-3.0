import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:healthcare2050/Api/Api.dart';
import 'package:healthcare2050/Model/map/map_markers_model.dart';
import 'package:http/http.dart' as http;

class MapsApis{
  Future<List<MapMarkersModel>> getAllMarkers()async{
    var url = Uri.parse(mapMarkersApi);
    var response = await http.get(url);
    if(response.statusCode == 200){
      var resData = jsonDecode(response.body);
      if(resData['status'] == true){
        List data = resData['AddressDataFeth'];
        return data.map((e) => MapMarkersModel.fromJson(e)).toList();
      }else{
        return List<MapMarkersModel>.empty();
      }
    }else{
      return List<MapMarkersModel>.empty();
    }
  }
}

class MarkerOnMapProvider extends ChangeNotifier{
  List<MapMarkersModel> _allMarkers = <MapMarkersModel>[];

  List<MapMarkersModel> get getAllMarkers => _allMarkers;

   getMarkers()async{
    var url = Uri.parse(mapMarkersApi);
    var response = await http.get(url);
    if(response.statusCode == 200){
      var resData = jsonDecode(response.body);
      if(resData['status'] == true){
        List data = resData['AddressDataFeth'];
        _allMarkers = data.map((e) => MapMarkersModel.fromJson(e)).toList();
      }else{
        _allMarkers = <MapMarkersModel>[];
      }
    }
    notifyListeners();
  }
}