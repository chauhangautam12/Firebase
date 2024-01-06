

import 'package:cgm/Screen/Apifeachpractice/Apifeachclass/Apifeachdata.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../jsonformaat/Api.dart';
import 'json/Apijson.dart';
class Apipre extends GetxController{

var loding=true.obs;
var userlist=<Apijson>[].obs;
@override
void onInit(){
  feachprouduct();
  super.onInit();
}

 feachprouduct() async {
  try{
    loding(true);
    var product=await Apifeachdata.feachdata();

      userlist.addAll(product as Iterable<Apijson>);

  }catch(e){
    print("error");
  }

  finally{
    loding(false);
  }
}

}