import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("CUSTOMER ADDING FORM",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: formFieldForCustomer(),
    );
  }
  Widget formFieldForCustomer(){
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
                borderSide: BorderSide(color: Colors.blue,width: 2)
              )
            ),
            validator: (value){
              if(value!.isEmpty){
                return "invalid";
              }
              return "";
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
                    borderSide: BorderSide(color: Colors.blue,width: 2)
                )
            ),
            validator: (value){
              if(value!.isEmpty){
                return "invalid";
              }
              return "";
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
                    borderSide: BorderSide(color: Colors.blue,width: 2)
                )
            ),
            maxLines: 4,
            validator: (value){
              if(value!.isEmpty){
                return "invalid";
              }
              return "";
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
                    borderSide: BorderSide(color: Colors.blue,width: 2)
                )
            ),
            maxLines: 4,
            validator: (value){
              if(value!.isEmpty){
                return "invalid";
              }
              return "";
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
                    borderSide: BorderSide(color: Colors.blue,width: 2)
                )
            ),
            keyboardType: TextInputType.number,
            validator: (value){
              if(value!.isEmpty){
                return "invalid";
              }
              return "";
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
                    borderSide: const BorderSide(color: Colors.blue,width: 2)
                )
            ),
            validator: validateEmail
          ),
          SizedBox(height: 20,),
          Center(
            child: MaterialButton(
              onPressed: (){
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
  String ? validateEmail(value){
    if(value!.isEmpty){
      return "Please enter the email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegExp.hasMatch(value)){
      return "not a valid email";
    }
    return "";
  }
  void _submitButton(){
    if(_formKey.currentState!.validate()){
    }
  }
}
