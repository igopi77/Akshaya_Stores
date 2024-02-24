import 'package:flutter/material.dart';
import 'package:stock_management_akshaya_store/service/agency-service/agency_service.dart';
import 'package:stock_management_akshaya_store/service/sales-service/fetch_stack_name_service.dart';

class StockSellingPage extends StatefulWidget {
  const StockSellingPage({super.key});

  @override
  State<StockSellingPage> createState() => _StockSellingPageState();
}

class _StockSellingPageState extends State<StockSellingPage> {

  FetchAgencyData fetchAgencyData = FetchAgencyData();
  FetchStackNameService fetchStockName = FetchStackNameService();
  late Future<Map<String,dynamic>> companyList ;
  late Future<Map<String,dynamic>> stockList;
  String dropDownValueForCompany = "select";
  String dropDownValueForStock = "select";

  @override
  void initState(){
    super.initState();
    companyList = fetchAgencyData.fetchAgencyData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STOCK SELLING PAGE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: formFeildForSelling(),
    );
  }
  Widget formFeildForSelling(){
    return FutureBuilder(
        future: companyList,
        builder: (context,snapShotForCompany){
          if(snapShotForCompany.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          else if(snapShotForCompany.hasError){
            return Text("It have a error in snapshot");
          }
          else{
            stockList = fetchStockName.fetchStockName(dropDownValueForCompany);
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
                    return Form(
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          company(snapShotForCompany.data ?? {}),
                          SizedBox(height: 50,),
                          stock(snapShotForStock.data ?? {})
                        ],
                      ),
                    );
                  }
                });
          }
        }
    );
  }

  Widget company(Map<String,dynamic> data){
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down_rounded),
            iconSize: 20,
            isExpanded: true,
            value: dropDownValueForCompany,
            elevation: 16,
            onChanged: (String ? newValue){
              setState(() {
                dropDownValueForCompany = newValue!;
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: "select",
                child: Text("Select Your Company"),
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
            onChanged: (String ? newValue){
              setState(() {
                dropDownValueForStock = newValue!;
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
}
