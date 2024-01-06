
import 'package:cgm/Screen/Apifeachpractice/Apipractice.dart';
import 'package:cgm/Screen/Splashscreen.dart';
import 'package:cgm/Screen/Userinfo.dart';
import 'package:cgm/Screen/phoneauthentication/authentication.dart';
import 'package:cgm/Screen/phoneauthentication/phoneauthentication.dart';
import 'package:cgm/Screen/profilescreen.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:get/get.dart';

import 'Screen/ApiScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?await Firebase.initializeApp(options:
  FirebaseOptions(apiKey:'AIzaSyBf09W0_I5Gt58oMXHUKFRKrjNtAzT6Jb0',
      appId: '1:525485120477:android:f632949cc8d6e07e4af434',
      messagingSenderId: '525485120477',
      projectId: 'tryf-75e6f')):await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool islogin=false;
  getloginStatus()async{
    await authentication.getlogindata().then((loginstatus) {
      setState((){
        islogin=loginstatus!;
      });
    },);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getloginStatus();
  }
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:islogin?Userinfo():profilescreen()
    );
  }
}

