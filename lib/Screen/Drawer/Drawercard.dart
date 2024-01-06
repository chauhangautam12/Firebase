import 'package:cached_network_image/cached_network_image.dart';
import 'package:cgm/jsonmodel/json.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Api/Api.dart';

class Drawercard extends StatefulWidget {
  const Drawercard({super.key, required this.user});
  final Datafeach user;
  @override
  State<Drawercard> createState() => _DrawercardState();
}

class _DrawercardState extends State<Drawercard> {
  final formkey=GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    Apifirebase.selfinfo();
  }
  @override
  Widget build(BuildContext context) {

    return Form(
      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: 70,
              height: 70,
              imageUrl: widget.user.photo,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.08,),
          TextFormField(
            onSaved: (value) => Apifirebase.me.name=value??"",
            validator: (value) => value!=null&&value.isNotEmpty?null:"Required Field",cursorColor: CupertinoColors.extraLightBackgroundGray,
            initialValue: widget.user.name,style: TextStyle(color: CupertinoColors.extraLightBackgroundGray),
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
          MaterialButton(onPressed: (){
            if(formkey.currentState!.validate()){
              formkey.currentState?.save();
              Apifirebase.userupdated();
            }
          },child: Text("Update"),color: Colors.lime,)

        ],
      ),
    );
  }
}
