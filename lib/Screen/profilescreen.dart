import 'package:cgm/Api/Api.dart';
import 'package:cgm/Screen/Splashscreen.dart';
import 'package:cgm/Screen/Userinfo.dart';
import 'package:cgm/Screen/phoneauthentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {



  handlegooglesignin(){
   CircularProgressIndicator();
    signInWithGoogle().then((user) async {
      // Navigator.of(context).pop();
      authentication.Savelogin(true);
      if(user!=null) {
        if (await Apifirebase.userExists()) {
          // log('123:${user.user}' as num);

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Userinfo() ,));
        }else{
          await Apifirebase.CreateUser().then((value) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Userinfo(),));
          });
        }
      }

    });
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );


    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  // Future<void> checkuser() async {
  //   final FirebaseAuth auth=FirebaseAuth.instance;
  //   final user=await auth.currentUser;
  //
  // }
@override
void initState(){
  super.initState();
  Apifirebase.selfinfo();
  // checkuser();
}
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
        backgroundColor: Colors.lime,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         Padding(
           padding: const EdgeInsets.all(30.0),
           child: Center(child: SizedBox(
               width: 200,
               child: MaterialButton(onPressed:handlegooglesignin,child: Text("Sign in"),color: Colors.lime,))),
         ),
          // MaterialButton(onPressed:signOut,child: Text("Sign out"),)
        ],
      ),
    );
  }
}
