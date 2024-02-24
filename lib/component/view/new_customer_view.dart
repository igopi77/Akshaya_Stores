import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_akshaya_store/component/view/home_view.dart';

class NewCustomerAddingPage extends StatefulWidget {
  const NewCustomerAddingPage({super.key});

  @override
  State<NewCustomerAddingPage> createState() => _NewCustomerAddingPageState();
}

class _NewCustomerAddingPageState extends State<NewCustomerAddingPage> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeAddressController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerPhoneNumberController = TextEditingController();
  TextEditingController customerEmailAddressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool flag = false,decider=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CUSTOMER ADDING FORM",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: formFieldForCustomer(),
      ),
    );
  }

  Widget formFieldForCustomer() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: customerNameController,
            decoration: InputDecoration(
                hintText: "Customer Name",
                icon: Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2)
                )
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "invalid";
              }
              return null;
            },
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: storeNameController,
            decoration: InputDecoration(
                hintText: "Store Name",
                icon: Icon(Icons.perm_contact_cal_outlined),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2)
                )
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "invalid";
              }
              return null;
            },
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: storeAddressController,
            decoration: InputDecoration(
                hintText: "Store Address",
                icon: Icon(Icons.store),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2)
                )
            ),
            maxLines: 4,
            validator: (value) {
              if (value!.isEmpty) {
                return "invalid";
              }
              return null;
            },
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: customerAddressController,
            decoration: InputDecoration(
                hintText: "Customer Address",
                icon: Icon(Icons.home_filled),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2)
                )
            ),
            maxLines: 4,
            validator: (value) {
              if (value!.isEmpty) {
                return "invalid";
              }
              return null;
            },
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: customerPhoneNumberController,
            decoration: InputDecoration(
                hintText: "Customer Phone Number",
                icon: Icon(Icons.phone),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2)
                )
            ),
            keyboardType: TextInputType.number,
             validator: (value) {
              if (value!.isEmpty) {
                return "invalid";
              }
              return null;
            },
          ),
          SizedBox(height: 10,),
          TextFormField(
              controller: customerEmailAddressController,
              decoration: InputDecoration(
                  hintText: "Customer Email ",
                  icon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue, width: 2)
                  )
              ),
              validator: validateEmail
          ),
          SizedBox(height: 20,),
          Center(
            child: MaterialButton(
              onPressed: () {
                _submitButton();
              },
              child: Text("Submit"),
              color: Colors.blue,
            ),
          )
        ],
      ),

    );
  }

  String ? validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter the email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "not a valid email";
    }
    return null;
  }

  void _submitButton() {
    decider = _formKey.currentState!.validate();
    if (decider == true) {
      CollectionReference customerRef = FirebaseFirestore.instance.collection("customer");
      customerRef.add({
        "customerName" : customerNameController.text,
        "storeName" : storeNameController.text,
        "storeAddress" : storeAddressController.text,
        "customerAddress" : customerAddressController.text,
        "customerPhone" : customerPhoneNumberController.text,
        "customerEmail" : customerEmailAddressController.text
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
  }
}
