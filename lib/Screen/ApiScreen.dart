import 'dart:convert';

import 'package:cgm/jsonformaat/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  const Api({super.key});

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List<Apifeach>list=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: FutureBuilder(
        future: getApi(),
        builder: (context, snapshot) {
           if(snapshot.hasData){
             return ListView.builder(
               itemCount: list.length,
               itemBuilder: (BuildContext context, int index) {
                 return Container(
                   color: Colors.lime,
                   height: 120,
                   width: 400,
                   margin:EdgeInsets.all(10),
                   child: Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("User id:${list[index].userId}",style: TextStyle(fontSize: 10),),
                         Text("id:${list[index].id}",style: TextStyle(fontSize: 10)),
                         Text("title:${list[index].title}",maxLines: 1,style:TextStyle(fontSize: 10),),
                         Text("body:${list[index].body}",maxLines: 1,style: TextStyle(fontSize: 10)),
                       ],
                     ),
                   ),
                 );

               },
             );
           }
           return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  Future<List<Apifeach>>getApi()async{

    final responce= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    final data=jsonDecode(responce.body.toString());
    if(responce.statusCode==200){
      for(Map<String, dynamic>index in data){
        list.add(Apifeach.fromJson(index));
      }
      return list;
    }else{
      return list;
    }

  }
}
