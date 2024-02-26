
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchCustomerDetails{
  
  Future<Map<String,dynamic>> fetchCustomerName() async{
    Map<String,dynamic> customerData={};
    
    QuerySnapshot querySnapshotForCustomerName = await FirebaseFirestore.instance.collection("customer").get();
    
    querySnapshotForCustomerName.docs.forEach((docs) { 
      String customerName = docs.get("customerName");
      String docId = docs.id;
      customerData[docId] = customerName;
    });
    return customerData;
  }
}