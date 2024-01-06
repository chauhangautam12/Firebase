



import 'dart:async';

import 'package:cgm/Screen/Userinfo.dart';
import 'package:cgm/Screen/profilescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();

}
 late String? finalemail;
class _MyHomePageState extends State<MyHomePage> {



 Future getValidationdata()async{
    final SharedPreferences sp=await SharedPreferences.getInstance();

    final obtainvalue=sp.getString('email');
    setState(() {
            finalemail=obtainvalue;
    });

 }
  @override
  void initState(){
    getValidationdata().whenComplete(() async {
      Timer(Duration(seconds: 2), () {
       if(finalemail!=null){
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => Userinfo(),));
       }
       else{
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => profilescreen(),));
       }
      },);
    },);
    super.initState();
  }

 Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}

