import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Getxcontrol extends GetxController{
  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController pass=TextEditingController();

  final Future<SharedPreferences> prefs=SharedPreferences.getInstance();
  Future<void>registerwithemail()async{

    try {
      var header = {'Content-Type': 'application/json'};

      var uri = Uri.parse(
          'http://restapi.adequateshop.com/api/' + 'authaccount/registration');
      Map body = {
        'name': name.text,
        'pass': pass.text,
        'email': email.text,
      };
      http.Response response=await  http.post(uri,body: jsonEncode(body),headers: header);

      if(response.statusCode==200){
        final json=jsonDecode(response.body);
        if(json['code']==0){
          var token=json['data']['Token'];
          print(token);
          final SharedPreferences Prefs=await prefs;
        }
      }
    }catch (e){

    }
  }
}