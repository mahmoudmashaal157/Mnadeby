import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static sharedPrefenceInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({required String key, required value}) {
    if(value is int){
      return sharedPreferences.setInt(key, value);
    }
    else if(value is String){
      return sharedPreferences.setString(key, value);
    }
    else if(value is bool){
      return sharedPreferences.setBool(key, value);
    }
    else if(value is double){
      return sharedPreferences.setDouble(key, value);
    }
    else {
      return sharedPreferences.setStringList(key, value);
    }
  }

  static getData({required key}){
    return sharedPreferences.get(key);
  }

  static Future<bool>removeData({required String key}){
    return sharedPreferences.remove(key);
  }
}
