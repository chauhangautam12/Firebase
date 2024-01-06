
import 'package:shared_preferences/shared_preferences.dart';

class authentication {
  static Future<bool> Savelogin(bool user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool("logkey", user);
  }
  static Future<bool?>getlogindata()async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    return await sp.getBool("logkey");
  }
}