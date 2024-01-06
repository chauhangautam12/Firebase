import 'package:cgm/jsonmodel/json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Apifirebase{
  static FirebaseAuth auth=FirebaseAuth.instance;
  static FirebaseFirestore Storage=FirebaseFirestore.instance;
  static Datafeach me = Datafeach(
    name: auth.currentUser!.email.toString(),
      photo:auth.currentUser!.photoURL.toString()
      );
  static Future<bool>userExists()async{//user check karva
    return( await Storage.collection('user').doc(auth.currentUser!.uid).get()).exists;
  }
  static Future<void>CreateUser()async{
    final user=Datafeach(name: auth.currentUser!.email.toString(), photo: auth.currentUser!.photoURL.toString());

    return await Storage.collection('user').doc(auth.currentUser?.uid).set(user.toJson());
  }
  static Future<void>selfinfo()async{//user check karva
     await Storage.collection('user').doc(auth.currentUser?.uid).get().then((user) async {
      if(user.exists){
          me=await Datafeach.fromJson(user.data()!);
      }else{
       await CreateUser().then((value) => selfinfo(),);
      }
     } ,);
  }
  static Future<void>userupdated()async{//user update karva
    await Storage.collection('user').doc(auth.currentUser!.uid).update({
      'name':me.name,
    });
  }
  static Future<void>userdelet(id)async{//user update karva
    await Storage.collection('user').doc(id).delete();
  }


}