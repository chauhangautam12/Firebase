import 'package:cgm/Screen/Apifeachpractice/Getxwithapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class api extends StatefulWidget {
  const api({super.key});

  @override
  State<api> createState() => _apiState();
}

class _apiState extends State<api> {
  Apipre controller=Get.put(Apipre());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //
      // ),
      body:Obx(() {
        if(controller.loding.value){
          return Center(child: CircularProgressIndicator(),);
        }else{
            return ListView.builder(
              itemCount: controller.userlist.length,
              itemBuilder:(context, index) {
               return Container(
                 child: Column(
                   children: [
                     ListTile(
                       title:  Text("${controller.userlist[index].id}"),
                       leading:Image.network(controller.userlist[index].url,width: 30,height: 30,) ,
                     )
                   ],
                 ),
               );
            },);

        }
      })

    );
  }
}
