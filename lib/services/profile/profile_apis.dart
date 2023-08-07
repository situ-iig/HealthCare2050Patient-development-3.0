import 'dart:convert';
import 'dart:typed_data';

import 'package:healthcare2050/Providers/user_details_provider.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';
import 'package:http/http.dart' as http;

import '../../Api/Api.dart';

class ProfileApis {
  Future<bool> updateUserDetails( String email,
      String city, String state, String pincode, String address,UserDetailsProvider provider) async {
    var userId = await getStringFromLocal(userIdKey);
    var mobile = await getStringFromLocal(userMobileKey);
    var url = Uri.parse(profileEditApi);
    var response = await http.post(url, body: {
      "userId": userId,
      "Email": email,
      "MobileNumber": mobile,
      "City": city,
      "State": state,
      "Pincode": pincode,
      "Address": address,
    });

    if(response.statusCode == 200){
      var resData = jsonDecode(response.body);
      if(resData['status'] == true){
        provider.addEmail(email);
        provider.addAddress(address);
        provider.addPinCode(pincode);
        provider.addCity(city);
        provider.addState(state);
        provider.addUserId(userId);

        await storeStringToLocal(userEmailKey, email);
        await storeStringToLocal(userAddressKey, address);
        await storeStringToLocal(userCityKey, city);
        await storeStringToLocal(userPinCodeKey, pincode);
        await storeStringToLocal(userStateKey, state);
        await storeStringToLocal(userAddressKey, address);
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  Future<bool> uploadUserImage(Uint8List bytes,UserDetailsProvider provider) async {
    var userId = await getStringFromLocal(userIdKey);
    final http.Response response = await http.post(
      Uri.parse(profileImageUploadApi),
      body: {'userId': userId, 'Image': base64Encode(bytes)},
    );

    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      if (resData['status'] == true) {
        provider.addProfilePic(resData['Image']);
        return true;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
