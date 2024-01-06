import 'package:cgm/Screen/phoneauthentication/Getxfile.dart';
import 'package:cgm/Screen/phoneauthentication/Otp/OtpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Userinfo.dart';

class phoneauthentication extends StatefulWidget {
  const phoneauthentication({super.key});

  @override
  State<phoneauthentication> createState() => _phoneauthenticationState();
}

class _phoneauthenticationState extends State<phoneauthentication> {
  final TextEditingController phone = TextEditingController();
  bool loading=true;
  static FirebaseAuth auth=FirebaseAuth.instance;
  final Getx controller=Get.put(Getx());
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
            decoration: const InputDecoration(hintText: "+91-No",
            // prefixText: '+91'
            ),
          ),
          SizedBox(height: 80,),
          MaterialButton(onPressed: (){
            setState(() {
              loading=true;
            });
            auth.verifyPhoneNumber(
              phoneNumber:phone.text,
              verificationCompleted:(phoneAuthCredential) {
                setState(() {
                  loading=false;
                });
              },
              verificationFailed: (error) {
                setState(() {
                  loading=false;
                });
                Get.snackbar("Error", "${error}");
              },
              codeSent: (String verificationId,int? forceResendingToken) {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(VerificationId: verificationId),));
               setState(() {
                 loading=false;
               });
              },
              codeAutoRetrievalTimeout: (error) {
                Get.snackbar("Error", "${error}");
                setState(() {
                  loading=false;
                });
              },);
          },child: Text("Submit"),),
        ],
      ),
    );
  }
}
