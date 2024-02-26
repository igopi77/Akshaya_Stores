import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_management_akshaya_store/service/agency-service/agency_service.dart';
import 'package:stock_management_akshaya_store/service/sales-service/fetch_customer_details.dart';
import 'package:stock_management_akshaya_store/service/sales-service/fetch_stack_name_service.dart';

class StockSellingPage extends StatefulWidget {
  const StockSellingPage({super.key});

  @override
  State<StockSellingPage> createState() => _StockSellingPageState();
}

class _StockSellingPageState extends State<StockSellingPage> {

  FetchAgencyData fetchAgencyData = FetchAgencyData();
  FetchStackDetails fetchStockDetails = FetchStackDetails();
  FetchCustomerDetails fetchCustomerDetails = FetchCustomerDetails();
  late Future<Map<String,dynamic>> companyList ;
  late Future<Map<String,dynamic>> stockList;
  late Future<Map<String,dynamic>> customerList;
  String dropDownValueForStock = "select";
  String dropDownValueForCustomer = "select";
  String availableQuantity ="";
  String mprSetted ="";
  String gstSetted = "";
  TextEditingController quantityController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    print("first checkpoint");
    super.initState();
    stockList = fetchStockDetails.fetchStockName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("STOCK SELLING PAGE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: formFeildForSelling(),
      ),
    );
  }
  Widget formFeildForSelling(){
    return FutureBuilder(
        future: stockList,
        builder: (context,snapShotForStock){
          if(snapShotForStock.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if(snapShotForStock.hasError){
            return Text("It have a error in snapshot");
          }
          else{
            customerList = fetchCustomerDetails.fetchCustomerName();
            return FutureBuilder(
                future: customerList,
                builder: (context,snapShotForCustomer){
                  if(snapShotForCustomer.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  else if(snapShotForCustomer.hasError){
                    return Text("It have a error in snapshot");
                  }
                  else{
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          stock(snapShotForStock.data ?? {}),
                          SizedBox(height: 20,),
                          customer(snapShotForCustomer.data ?? {}),
                          SizedBox(height: 20,),
                          Card(
                            color: Colors.red.shade300,
                            child: Column(
                              children: [
                                Center(child: Text("Information about your product ", style: TextStyle(color: Colors.white,fontSize: 20),),),
                                SizedBox(height: 10,),
                                Text("Quantity Available in a Store : $availableQuantity", style: TextStyle(color: Colors.white,fontSize: 17),),
                                SizedBox(height: 10,),
                                Text("MRP You already set in a Store : $mprSetted", style: TextStyle(color: Colors.white,fontSize: 17),),
                                SizedBox(height: 10,),
                                Text("GST you set in a Store : $gstSetted", style: TextStyle(color: Colors.white,fontSize: 17),),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter your quantity",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue,width: 2),
                                ),
                                icon: Icon(Icons.join_inner_sharp)
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                            ],
                            validator: (value){
                              if(value!.isEmpty){
                                return "invalid";
                              }
                              return "";
                            },
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter your MRP",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue,width: 2),
                                ),
                                icon: Icon(Icons.attach_money)
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                            ],
                            validator: (value){
                              if(value!.isEmpty){
                                return "invalid";
                              }
                              return "";
                            },
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter your GST ( if 'NO' enter '0' )",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue,width: 2),
                                ),
                                icon: Icon(Icons.gpp_good_sharp)
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                            ],
                            validator: (value){
                              if(value!.isEmpty){
                                return "invalid";
                              }
                              return "";
                            },
                          ),
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child:Text("ADD",style: TextStyle(color: Colors.red,fontSize: 20),)
                          )
                        ],
                      ),
                    );
                  }
                }
            );
          }
        });
  }
  Widget stock(Map<String,dynamic> data){
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down_rounded),
            iconSize: 20,
            isExpanded: true,
            value: dropDownValueForStock,
            elevation: 16,
            onChanged: (String ? newValue)  async{
              setState(() {
                dropDownValueForStock = newValue!;
              });
              setState(() {
                fetchStockDetails.setBasicInformation(dropDownValueForStock);
                availableQuantity = fetchStockDetails.getQuantity();
                mprSetted = fetchStockDetails.getMrp();
                gstSetted = fetchStockDetails.getGst();
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: "select",
                child: Text("Select Your Stock"),
              ),
              ...data.values
                  .toSet()
                  .toList()
                  .map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(value.toString()),
                );
              }).toList(),
            ],
          ),
        )
      ],
    );
  }

  Widget customer(Map<String,dynamic> data){
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down_rounded),
            iconSize: 20,
            isExpanded: true,
            value: dropDownValueForCustomer,
            elevation: 16,
            onChanged: (String ? newValue){
              setState(() {
                dropDownValueForCustomer = newValue!;
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: "select",
                child: Text("Select Your Customer"),
              ),
              ...data.values
                  .toSet()
                  .toList()
                  .map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(value.toString()),
                );
              }).toList(),
            ],
          ),
        )
      ],
    );
  }
}
