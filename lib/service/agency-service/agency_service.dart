
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchAgencyData{

  Future<Map<String, dynamic>> fetchAgencyData() async{
    Map<String,dynamic> agencyData = {};

    try{
      QuerySnapshot querySnapshotAgency = await FirebaseFirestore.instance.collection("agency").get();
      querySnapshotAgency.docs.forEach((docs){ 
        String agencyName = docs.get("agencyName");
        print(agencyName);
        String agencyId = docs.id;
        agencyData[agencyId] = agencyName ;
      });
    }
    catch(e){
        print(e);
    }
    print(agencyData["yee4cehFbSyMmctOJVxF"]);
    return agencyData;
  }

}