import 'dart:async';

import 'package:cgm/Screen/Apifeachpractice/json/Apijson.dart';
import 'package:http/http.dart' as http;

class Apifeachdata{


  static Future<List<Apijson>?>feachdata()async{
    var respon=await  http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if(respon.statusCode==200){
      var jsonString=respon.body;
      return apijsonFromJson(jsonString);
    }
    else{
      return null;
    }
  }
}