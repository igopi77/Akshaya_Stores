
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchStackDetails{
  //late String company;
 // late String cost;
  String mrp="";
  String quantity="";
  String ourStockName="";
  String gst="";
  
  Future<Map<String,dynamic>> fetchStockName() async {
    Map<String,dynamic> stockData ={};
    
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("stockAdding").get();
    querySnapshot.docs.forEach((docs) {
      String stockName = docs.get("type");
      String documentID = docs.id;
      stockData[documentID] = stockName;
    });
    return stockData;
  }
  
  void setBasicInformation(String stockName) async{
    print("iam now only clicked");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("stockAdding").get();
    querySnapshot.docs.forEach((docs) {
      if(docs.get("type") == stockName){
        quantity = docs.get("quantity");
        mrp = docs.get("mrp");
        gst = docs.get("gst");
      }
    });
  }
  String getQuantity(){
    return quantity;
  }
  String getMrp(){
    return mrp;
  }
  String getGst(){
    return gst;
  }
}