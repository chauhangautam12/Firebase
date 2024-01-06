import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgm/Api/Api.dart';
import 'package:cgm/Screen/ApiScreen.dart';
import 'package:cgm/jsonmodel/json.dart';
import 'package:flutter/material.dart';

class Userinfocard extends StatefulWidget {
  const Userinfocard({super.key, required this.user});
  final Datafeach user;

  @override
  State<Userinfocard> createState() => _UserinfocardState();
}

class _UserinfocardState extends State<Userinfocard> {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          title:Text(widget.user.name) ,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              imageUrl: widget.user.photo,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          trailing: IconButton(onPressed: (){

          }, icon: Icon(Icons.delete)) ,
        ),
      ],
    );
  }
}
