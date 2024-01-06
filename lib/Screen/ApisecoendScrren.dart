import 'dart:convert';

import 'package:cgm/jsonformaat/Apidetailsdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ApisecoendScrren extends StatefulWidget {
  const ApisecoendScrren({super.key});

  @override
  State<ApisecoendScrren> createState() => _ApisecoendScrrenState();
}

class _ApisecoendScrrenState extends State<ApisecoendScrren> {
  
  List<Apifdetailefeach>list=[];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getapi(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
            return Container(
              height: 500,
              margin: EdgeInsets.all(10),
              color: Colors.lime,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("id:${list[index].id}"),
                  Text("name:${list[index].name}"),
                  Text("username:${list[index].username}"),
                  Text("email:${list[index].email}"),
                  Text("address:"),
                  Text("Streets:${list[index].address.street}"),
                  Text("suite:${list[index].address.suite}"),
                  Text("city:${list[index].address.city}"),
                  Text("Zipcode:${list[index].address.zipcode}"),
                   Text("geo:"),
                  Text("geo-lat:${list[index].address.geo.lat}"),
                  Text("geo-lng:${list[index].address.geo.lng}"),
                  Text("Phone:${list[index].phone}"),
                  Text("website:${list[index].website}"),
                  Text("Company:"),
                  Text("Com-name:${list[index].company.name}"),
                  Text("Com-catch:${list[index].company.catchPhrase}"),
                  Text("Com-bs:${list[index].company.bs}"),
                ],
              ),
            );
          }, );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
  Future<List<Apifdetailefeach>>getapi()async{
    final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    final data= await jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map<String, dynamic>index in data){
        list.add(Apifdetailefeach.fromJson(index));
      }
      return list;
    }
    return list;
  }
}
