import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_management_akshaya_store/component/view/home_view.dart';
import 'package:stock_management_akshaya_store/service/agency-service/agency_service.dart';

class StockAddingPage extends StatefulWidget {
  const StockAddingPage({super.key});

  @override
  State<StockAddingPage> createState() => _StockAddingPageState();
}

class _StockAddingPageState extends State<StockAddingPage> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController gstController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Future<Map<String,dynamic>> agencyList;
  String dropDownValueForAgency = "select";
  FetchAgencyData fetchAgencyData = FetchAgencyData();

  @override
  void initState(){
    super.initState();
    agencyList = fetchAgencyData.fetchAgencyData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("STOCK ADDING PAGE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: formFeildForStockAdding(),
    );
  }
  Widget formFeildForStockAdding(){
    return FutureBuilder<Map<String,dynamic>>(
        future: agencyList,
        builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return Center(child: Text("it has a error sorry"));
            }
            else{
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    agency(snapshot.data ?? {}),
                    TextFormField(
                      controller: quantityController,
                      decoration: InputDecoration(
                          hintText: "Enter Quantity",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue,width: 2)
                          ),
                          icon: Icon(Icons.join_inner_sharp)
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value){
                        if(value!.isEmpty){
                          return "invalid";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: typeController,
                      decoration: InputDecoration(
                        hintText: "Enter Stock Name (pen,pencil..)",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue,width: 2)
                        ),
                        icon: Icon(Icons.emoji_food_beverage_sharp),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "invalid";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: costController,
                      decoration: InputDecoration(
                          hintText: "Enter Cost (actual price)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue,width: 2)
                          ),
                          icon: Icon(Icons.attach_money)
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value){
                        if(value!.isEmpty){
                          return "invalid";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: mrpController,
                      decoration: InputDecoration(
                          hintText: "Enter MRP (price to consumer)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue,width: 2)
                          ),
                          icon: Icon(Icons.money_outlined)
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value){
                        if(value!.isEmpty){
                          return "invalid";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: gstController,
                      decoration: InputDecoration(
                          hintText: "GST Percentage",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue,width: 2)
                          ),
                          icon: Icon(Icons.gpp_good_sharp)
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value){
                        if(value!.isEmpty){
                          return "invalid";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Write some description about a product (optional)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue,width: 2)
                          ),
                          icon: Icon(Icons.note)
                      ),
                      maxLines: 4,
                    ),
                    SizedBox(height: 40,),
                    Center(
                      child: MaterialButton(
                        onPressed: (){
                          _submit();
                        },
                        child: Text("Submit"),
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              );
            }
        }
    );
  }

  void _submit(){
    bool decider = _formKey.currentState!.validate();
    print(mrpController.text);
    if(decider == true && dropDownValueForAgency.isNotEmpty){
      CollectionReference stockReference = FirebaseFirestore.instance.collection("stockAdding");
      stockReference.add({
        "company" : dropDownValueForAgency,
        "quantity" : quantityController.text,
        "type" : typeController.text,
        "cost" : costController.text,
        "mrp" : mrpController.text,
        "gst" : gstController.text,
        "note" : noteController.text
      });
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              backgroundColor: Colors.grey,
              title:  const Text("INFORMATION",style: TextStyle(fontSize: 25),),
              content: const Text("Entered data succesfully inserted",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.normal,fontSize: 20),),
              actions: [
                MaterialButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage())
                    );
                  },
                  child: Text("OK"),
                )
              ],
            );
          }
      );
    }
    else
    {
      print("vanakam");
    }
  }

  Widget agency(Map<String,dynamic> data){
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down_rounded),
            iconSize: 20,
            isExpanded: true,
            value: dropDownValueForAgency,
            elevation: 16,
            onChanged: (String ? newValue){
              setState(() {
                dropDownValueForAgency = newValue!;
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: "select",
                child: Text("Select Your Agency"),
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
