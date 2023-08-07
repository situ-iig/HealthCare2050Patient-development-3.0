import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart' as location;
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class GetCurrentLocationDataProvider with ChangeNotifier {
  var _location = location.Location();
  bool _hasServiceEnabled = false;

  String _userAddress = "Address Loading....";

  String get userAddress => _userAddress;

  getAddressByLocation() {
    if (_hasServiceEnabled == false) {
      _enableLocationService();
    } else {
      checkPermissionAndData();
    }
  }

  _enableLocationService() async {
    var service = await _location.serviceEnabled();
    if (service == false) {
      await _location.requestService();
      _hasServiceEnabled = false;
      _enableLocationService();
      notifyListeners();
      Fluttertoast.showToast(msg: "Please enable location");
    } else {
      _hasServiceEnabled = true;
      checkPermissionAndData();
      notifyListeners();
    }
  }


  Future<bool> checkPermissionAndData() async {
    bool locationStatus = await Permission.location.isDenied;
    if (locationStatus) {
      await _location.requestPermission();
      checkPermissionAndData();
      await Permission.location.shouldShowRequestRationale;
      return false;
    } else {
      var data = await _location.getLocation();
      _getAddress(data);
      return true;
    }
  }

  _getAddress(location.LocationData data) async {
    var addresses = await geo.placemarkFromCoordinates(
        data.latitude ?? 0.0, data.longitude ?? .0);
    var first = addresses.first;
    _userAddress =
        (' ${first.name},${first.subLocality}, ${first.street},${first.locality}, ${first.thoroughfare}, ${first.subThoroughfare}');
    notifyListeners();
  }
}
