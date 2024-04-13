
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  int subTotal = 5000;
  int tax = 3000;
  int paidAmount = 7000;
  int due = 300;
  String dropDownValueForStock = "select";
  String dropDownValueForCustomer = "select";
  String availableQuantity ="";
  String mprSetted ="";
  String gstSetted = "";
  TextEditingController quantityController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController countController = TextEditingController();


  @override
  void initState(){
    super.initState();
    countController.addListener(_updateItemCount);
  }

  void _updateItemCount(){
    setState(() {

    });
  }

  @override
  void dispose(){
    countController.removeListener(_updateItemCount);
    countController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("STOCK SELLING PAGE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: formFeildForSelling(),
      ),
    );
  }
  Widget formFeildForSelling(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50,),
        const Text("From",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black),),
        const SizedBox(height: 20,),
        containerForFrom(context,"Owner:", "Muthuraja"),
        SizedBox(height: 10,),
        containerForFrom(context, "Email:", "muthuroja@gmail.com"),
        SizedBox(height: 10,),
        containerForFrom(context, "Phone Number:", "9433751909"),
        SizedBox(height: 30,),
        Text("Bill To",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 20,),
        containerForFrom(context,"Owner:", "Sothuraja"),
        SizedBox(height: 10,),
        containerForFrom(context, "Email:", "sothuraja@gmail.com"),
        SizedBox(height: 10,),
        containerForFrom(context, "Phone Number:", "9433751909"),
        SizedBox(height: 30,),
        Text("Invoice :",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        containerForFrom(context, "Invoice no :", "121FGS43"),
        SizedBox(height: 10,),
        containerForFrom(context, "Due date :", "18/02/2003"),
        SizedBox(height: 20,),
        Card(
          child: Row(
            children: [
              Text("Add",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(width: MediaQuery.of(context).size.width/13,),
              Text("Product",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(width: MediaQuery.of(context).size.width/13,),
              Text("Rate",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(width: MediaQuery.of(context).size.width/13,),
              Text("Qty",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(width: MediaQuery.of(context).size.width/13,),
              Text("Amount",style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(width: MediaQuery.of(context).size.width/13,),
            ],
          ),
        ),
        tableForSelling(context),
        SizedBox(height: 20,),
        MaterialButton(onPressed: (){

        },
          child: Text("ADD ITEMS",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,),),
          color: Colors.green,
        ),
        Center(
          child: billing(),
        ),
        SizedBox(height: 20,),
        Center(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Write some notes or remainder",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2)
              )
            ),
            maxLines: 4,
          ),
        ),
        SizedBox(height: 30,),
        Center(
          child: Text("Vist again ;) ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        )
      ],
    );
  }

  Widget billing(){
    return Column(
      children: [
        Text("Billing",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        Card(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sub Total : ${subTotal}",style: TextStyle(fontSize: 20),),
              SizedBox(height: 20,),
              Text("Tax : ${tax}",style: TextStyle(fontSize: 20)),
              SizedBox(height: 20,),
              Text("Paid Amount : $paidAmount",style: TextStyle(fontSize: 20)),
              SizedBox(height: 20,),
              Text("Due : ${due}",style: TextStyle(fontSize: 20))
            ],
          ),
        )
      ],
    );
  }
  Widget containerForFrom(BuildContext context,String left,String right){
    return Container(
      width: (MediaQuery.of(context).size.width)/1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
          color: Colors.grey.shade300,
          boxShadow: [
            BoxShadow(
              color: Colors.white10.withOpacity(0.5), // Shadow color
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: Offset(0, 3), // Offset
            )
          ]
      ),
      child: Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceAround, // change when it needed designed based on mobile
        children: [
           Text(left, style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: Colors.black),),
           Text(right,style: TextStyle(fontSize: 17),)
        ],
      ),
    );
  }

  Widget textField(String hint){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey,fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue,width: 2)
            )
        ),
      ),
    );
  }

  Widget tableForSelling(BuildContext context){
    return Card(
      child: Column(
        children: List.generate(5, (index) {
          return Row(
            children: [
              MaterialButton(onPressed: (){
                
              }, 
                child: Icon(Icons.add),
              ),
              SizedBox(width: MediaQuery.of(context).size.width/13,),
              Text("Cricket Bat",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),
              SizedBox(width: MediaQuery.of(context).size.width/13),
              Text("100000",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),
              SizedBox(width: MediaQuery.of(context).size.width/13,),
              Text("50",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),
              SizedBox(width: MediaQuery.of(context).size.width/13,),
              Text("95000",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),),
              SizedBox(width: MediaQuery.of(context).size.width/13,),
            ],
          );
        }),
      ),
    );
  }
}
