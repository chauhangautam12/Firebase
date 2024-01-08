

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgm/Api/Api.dart';
import 'package:cgm/Screen/ApiScreen.dart';
import 'package:cgm/Screen/ApisecoendScrren.dart';
import 'package:cgm/Screen/Drawer/Drawercard.dart';
import 'package:cgm/Screen/Userinfocard.dart';
import 'package:cgm/Screen/phoneauthentication/authentication.dart';
import 'package:cgm/Screen/profilescreen.dart';
import 'package:cgm/jsonmodel/json.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Userinfo extends StatefulWidget {

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {

   List<Datafeach> list=[];
 User? user=FirebaseAuth.instance.currentUser;
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text("logout"))
      );
      await FirebaseAuth.instance.signOut().then((value) async {
        await googleSignIn.signOut().then((value) async {
          Apifirebase.auth=FirebaseAuth.instance;
          authentication.Savelogin(false);
          Navigator.pop(context);
           Navigator.pop(context);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => profilescreen(),));
        },);
      },);


    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text("Error"))

      );
    }
  }
  @override
   void initState() {
    super.initState();
    setState(() {
      Apifirebase.selfinfo();
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     appBar: AppBar(

       toolbarHeight: 70,
       centerTitle: true,
       flexibleSpace: Container(

       decoration: BoxDecoration(
           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
           gradient: LinearGradient(
           // begin: Alignment.center,
           // end: Alignment.bottomLeft,

           colors: [
         Colors.limeAccent,Colors.red,Colors.lime])),

       ) ,
       title: Text("User Info",style: TextStyle(color: Colors.white)),
       backgroundColor: Colors.white,
     ),
      drawer: Drawer(
        width: 250,
        backgroundColor: Colors.black,
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                  Text("Hello:-",style: TextStyle(color: Colors.white,fontSize: 20),),

                ],
              ),
            ),
              Drawercard(user:Apifirebase.me),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.37,
            ),
            MaterialButton(onPressed:signOut,child: Text("Sign Out"),color: Colors.lime,),
          ],
        ) ,
      ),
      body: StreamBuilder(stream: Apifirebase.Storage.collection("user").snapshots(),
        builder:(context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
          case ConnectionState.none:
          return CircularProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:

            final data=snapshot.data?.docs;
            list=data?.map((e) => Datafeach.fromJson(e.data())).toList()??[];
          if(list.isNotEmpty){
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:Text('${snapshot.data?.docs[index]['name']}') ,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: snapshot.data?.docs[index]['photo'],
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  trailing: IconButton(onPressed: (){
                   Apifirebase.userdelet(snapshot.data!.docs[index].id);
                  }, icon: Icon(Icons.delete)),
                );
              }, );
          }else{
            return Center(child: Text("No user found"));
          }
        }
      },),
    );
  }
}
