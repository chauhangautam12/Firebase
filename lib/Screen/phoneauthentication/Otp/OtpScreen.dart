import 'package:cgm/Screen/Userinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OtpScreen extends StatefulWidget {
final String VerificationId;
   OtpScreen({super.key,required this.VerificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool loading=true;
  final TextEditingController phone=TextEditingController();
  static FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication"),
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          TextFormField(
            keyboardType: TextInputType.phone,
            controller:phone,
            decoration: const InputDecoration(hintText: "6 digit code"),
          ),
          SizedBox(height: 80,),
          MaterialButton(onPressed: () async {
            setState(() {
              loading=true;
            });
          final credential=PhoneAuthProvider.credential(
              verificationId:widget.VerificationId , smsCode: phone.text.toString());

          try{
            await auth.signInWithCredential(credential);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Userinfo(),));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sucessfully Connect"),));
          }catch(e){
            setState(() {
              loading=false;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed"),));
            });
          }
          },child: Text("Verify"),),
        ],
      ),
    );
  }
}
