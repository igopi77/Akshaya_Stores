import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_akshaya_store/component/view/new_customer_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController agencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade500,
                        Colors.grey.shade300,
                        Colors.grey.shade300,
                        Colors.grey.shade500
                      ]
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: Offset(0, 3), // Offset
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 100,left: 50,right: 50,bottom: 100),
                  child: Column(
                    children: [
                      stockManagement()
                    ],
                  ),
                ),
              ),
          ),
        ],
      )
    );
  }
  Widget stockManagement(){
    // TODO:1 = this will be updated
    return Column(
      children: [
        const Card(
        //width: 500,
        color: Colors.grey,
        child: Column(
          children: [
            Text("Stock Management",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 300,width: 300,)
          ],
        )
    ),
        SizedBox(height: 20,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewCustomerAddingPage())
                );
              },
              child: Text("ADD CUSTOMER"),
              color: Colors.blue,
            ),
            SizedBox(width: 30,),
            MaterialButton(
              onPressed: (){

              },
              child: Text("ADD STOCK"),
              color: Colors.blue,
            ),
            SizedBox(height: 20,),
            MaterialButton(
              onPressed: (){

              },
              child: const Text("SELL STOCK"),
              color: Colors.blue,
            ),
            SizedBox(width: 30,),
            MaterialButton(
              onPressed: (){
                _submit();
              },
              child: const Text("ADD NEW AGENCY"),
              color: Colors.blue,
            ),
          ],
        )
      ],
    );
  }
  Future _submit(){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("ADD NEW AGENCY",style: TextStyle(color: Colors.blue,fontSize: 20),),
            content: TextField(
              controller: agencyController,
              decoration: InputDecoration(
                  hintText: "Enter Agency",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue,width: 2)
                  )
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: (){
                  if(agencyController.text != "") {
                    CollectionReference agencyRef = FirebaseFirestore.instance
                        .collection("agency");
                    agencyRef.add({
                      "agencyName": agencyController.text
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text("Submit",style: TextStyle(color: Colors.blue),),
              )
            ],
          );
        }
    );
  }
}

