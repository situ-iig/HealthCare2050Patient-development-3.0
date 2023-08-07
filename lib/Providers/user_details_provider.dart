import 'package:flutter/material.dart';
import 'package:healthcare2050/utils/data/local_data_keys.dart';
import 'package:healthcare2050/utils/data/shared_preference.dart';


class UserDetailsProvider with ChangeNotifier{
  String _mobile = "Your Mobile Number";
  String get getMobile=>_mobile;

  String _userProfileUrl ="";
  String get getProfileImage => _userProfileUrl;

  String _userEmail ="Your Email";
  String get getEmail=> _userEmail;

  String _pinCode = "Your PinCode";
  String get getPinCode=>_pinCode;

  String _city ="Your City";
  String get getCityName => _city;

  String _state ="Your State";
  String get getStateName=> _state;

  String _address ="Your Address";
  String get getAddress=> _address;

  String _userId ="Your Address";
  String get getUserId=> _userId;


  getUserDetails()async{
    _mobile = await getStringFromLocal(userMobileKey);
    _userProfileUrl = await getStringFromLocal(userProfilePicKey);
    _userEmail = await getStringFromLocal(userEmailKey);
    _pinCode = await getStringFromLocal(userPinCodeKey);
    _city = await getStringFromLocal(userCityKey);
    _state = await getStringFromLocal(userStateKey);
    _address = await getStringFromLocal(userAddressKey);
    _userId = await getStringFromLocal(userIdKey);
    notifyListeners();
  }

  addMobile(String mobile)async{
    _mobile = mobile;
    await storeStringToLocal(userMobileKey, mobile);
    notifyListeners();
  }
  addEmail(String email)async{
    _userEmail = email;
    await storeStringToLocal(userEmailKey, email);
    notifyListeners();
  }
  addPinCode(String pin)async{
    _pinCode = pin;
    await storeStringToLocal(userPinCodeKey, pin);
    notifyListeners();
  }
  addCity(String city)async{
    _city = city;
    await storeStringToLocal(userCityKey, city);
    notifyListeners();
  }
  addState(String state)async{
    _state = state;
    await storeStringToLocal(userStateKey, state);
    notifyListeners();
  }

  addAddress(String address)async{
    _address = address;
    await storeStringToLocal(userAddressKey, address);
    notifyListeners();
  }

  addProfilePic(String picture)async{
    _userProfileUrl = picture;
    await storeStringToLocal(userProfilePicKey, picture);
    notifyListeners();
  }

  addUserId(String userId)async{
    _userId = userId;
    await storeStringToLocal(userIdKey, userId);
    notifyListeners();
  }
}