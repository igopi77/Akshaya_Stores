
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchStackNameService{
  
  Future<Map<String,dynamic>> fetchStockName(String company) async {
    Map<String,dynamic> stockData ={};
    
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("stockAdding").get();
    querySnapshot.docs.forEach((docs) {
      String companyName = docs.get("company");
      String stockName = docs.get("type");
      String documentID = docs.id;
      if(companyName == company){
        stockData[documentID] = stockName;
      }
      else{
        Dialog(
          child: AlertDialog(
            title: Text("INFORMATION",style: TextStyle(fontSize: 20),),
            content: Text("There is no data in name of the company"),
            backgroundColor: Colors.grey,
          ),
        );
      }
    });
    return stockData;
  }
}