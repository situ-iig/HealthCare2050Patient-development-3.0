import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthcare2050/services/maps/maps_apis.dart';
import 'package:healthcare2050/utils/helpers/internet_helper.dart';
import 'package:healthcare2050/view/pages/searches/search_city_details_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Model/map/map_markers_model.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> _markers = <Marker>[];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.9194163802794, 79.37364238977824),
    zoom: 4,
  );


  late BitmapDescriptor customIcon, targetIcon;

  @override
  void initState() {
    super.initState();

    InternetHelper(context: context)
        .checkConnectivityRealTime(callBack: (a) {});
    Provider.of<MarkerOnMapProvider>(context,listen: false).getMarkers();
  }

  List<Marker> getAllMarkers(List<MapMarkersModel> data){
    for (var i = 0; i < data.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(data[i].id.toString()),
        position: LatLng(double.parse(data[i].latitude != ""?data[i].latitude.toString():"0.0"),
            double.parse(data[i].longitude != ""?data[i].longitude.toString():"0.0")),
        infoWindow: InfoWindow(
            onTap: (){
              SearchCityDetailsScreen(cityId: data[i].cityId.toString(), cityName: data[i].cityName.toString(),).launch(context);
            },
            title:"${data[i].cityName},${data[i].stateName}",
            snippet:
            "${data[i].address}, ${data[i].address1}, ${data[i].address2},\n ${data[i].pincode}"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ));
    }
     return _markers;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Find on map"),
      ),
      body: Consumer<MarkerOnMapProvider>(
        builder: (a,data,b){
          return GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            markers: Set<Marker>.of(getAllMarkers(data.getAllMarkers)),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        },
      ),
    );
  }
}
