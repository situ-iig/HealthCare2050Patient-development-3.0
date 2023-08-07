

import 'package:nb_utils/nb_utils.dart';

// set data to local
storeStringToLocal(String key,String value)async{
  var pref = await SharedPreferences.getInstance();
  pref.setString(key, value);
}

storeDoubleToLocal(String key,double value)async{
  var pref = await SharedPreferences.getInstance();
  pref.setDouble(key, value);
}

storeBoolToLocal(String key,bool value)async{
  var pref = await SharedPreferences.getInstance();
  pref.setBool(key, value);
}

storeIntToLocal(String key,int value)async{
  var pref = await SharedPreferences.getInstance();
  pref.setInt(key, value);
}

// get data from local
Future<String> getStringFromLocal(String key)async{
  var pref = await SharedPreferences.getInstance();
  return pref.getString(key)??"";
}

Future<bool> getBoolFromLocal(String key)async{
  var pref = await SharedPreferences.getInstance();
  return pref.getBool(key)??false;
}
Future<double> getDoubleFromLocal(String key)async{
  var pref = await SharedPreferences.getInstance();
  return pref.getDouble(key)??0.0;
}
Future<int> getIntFromLocal(String key)async{
  var pref = await SharedPreferences.getInstance();
  return pref.getInt(key)??0;
}
