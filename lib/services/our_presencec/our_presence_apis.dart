import 'dart:convert';

import 'package:healthcare2050/Model/our_presence/our_presence_area_model.dart';
import 'package:healthcare2050/Model/our_presence/zone_by_state_model.dart';
import 'package:http/http.dart' as http;

import '../../Api/Api.dart';
import '../../Model/our_presence/state_by_city_model.dart';


class OurPresenceApis{
  Future<List<OurPresenceData>>getOurPresenceArea()async{
    var url = Uri.parse(our_presence_area_api);
    var response = await http.get(url);
    if(response.statusCode == 200){
      var resData = jsonDecode(response.body);
      if(resData['status'] == true){
        List data = resData['zoneWiseFetch'];
        return data.map((e) => OurPresenceData.fromJson(e)).toList();
      }else{
        return List<OurPresenceData>.empty();
      }
    }else{
      return List<OurPresenceData>.empty();
    }
  }

  Future<List<ZoneByStateModel>> getStateDataByZone(String zoneId)async{
    var url = Uri.parse(zoneWiseStateApi);
    var response = await http.post(url,body: {"zoneStateId":zoneId});
    if(response.statusCode == 200){
      var resData = jsonDecode(response.body);
      if(resData['status'] == true){
        List data = resData['stateDetails'];
        return data.map((e) => ZoneByStateModel.fromJson(e)).toList();
      }else{
        return List<ZoneByStateModel>.empty();
      }
    }else{
      return List<ZoneByStateModel>.empty();
    }
  }

  Future<List<StateByCityModel>>getStateWiseCityList(String stateId) async {

    var showStateWiseCityList_url= stateWiseCityApi;
    var response = await http.post(
        Uri.parse(showStateWiseCityList_url),
        body: {
          "zoneCityId" : stateId
        }
    );
    if(response.statusCode == 200){
      var resData = jsonDecode(response.body);
      if(resData['status'] == true){
        List data = resData['cityDetails'];
        return data.map((e) => StateByCityModel.fromJson(e)).toList();
      }else{
        return List<StateByCityModel>.empty();
      }
    }else{
      return List<StateByCityModel>.empty();
    }
  }

}


// A(){
//   showModalBottomSheet(
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20)
//           )
//       ),
//       elevation: 4,
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: ListView.builder(
//               itemCount: showStateWiseCityList.length,
//               itemBuilder: (context,index){
//                 return InkWell(
//                   onTap: (){
//                     setState(() {
//                       ZonePreference.cityId=showStateWiseCityList[index]['Id'].toString();
//                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CityFacilities()));
//                     });
//                   },
//                   child: Container(
//                     height: 50,
//                     color:  Colors.grey[100 * (index % 45)],
//                     // decoration: BoxDecoration(
//                     //   // gradient: LinearGradient(
//                     //   //   begin: Alignment.topRight,
//                     //   //   end: Alignment.bottomLeft,
//                     //   //   colors: [
//                     //   //     Colors.white,
//                     //   //     Colors.grey,
//                     //   //   ],
//                     //   // )
//                     // ),
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Text(showStateWiseCityList[index]['CityName'],textAlign: TextAlign.start,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.w800,
//                               fontSize: 20,color: Colors.black87
//                           ),),
//                       ),
//                     ),
//                   ),
//                 );
//
//                 // Text( showStateWiseCityList[index]['CityName']);
//               }
//           ),
//         );
//       }
//   );
// }