import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_akshaya_store/component/view/home_view.dart';
import 'package:stock_management_akshaya_store/service/login-service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  var authService = AuthService() ;
  var isLogged=false;
  var data;
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Akshaya Sports Stores",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),),
        backgroundColor: Colors.green.shade500,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade500,
              Colors.grey.shade300,
              Colors.grey.shade300,
              Colors.grey.shade500
            ]
          ),
        ),
        child: formFeildForLogin()
      )
    );
  }
  Widget formFeildForLogin(){

    return Padding(
        padding: EdgeInsets.only(top:100,bottom: 100,left: 50,right: 50),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: Offset(0, 3), // Offset
            )
          ]
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("LOGIN",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green,),textAlign: TextAlign.center,),
              SizedBox(height: 50,),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: usernameTextController,
                decoration: InputDecoration(
                  hintText: "Enter Your Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue,width: 2)),
                ),
                  validator: validateEmail
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: passwordTextController,
                decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue,width: 2)
                    )
                ),
                obscureText: true,
                  validator: (value){
                    if(value!.isEmpty){
                      return "please enter a password";
                    }
                    return "";
                  }
              ),
              SizedBox(height: 40,),

              Center(
                child: ElevatedButton(
                  onPressed: (){
                    isLogged ? null : submit();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: isLogged ? Center(child: CircularProgressIndicator()):
                      const Text("Submit",style: TextStyle(fontSize: 20),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> submit() async {
    setState(() {
      isLogged = true;
    });
    print("outside");
    //if(_formKey.currentState!.validate()){
      print("iam in submit button");
      data ={
        "email" : usernameTextController.text,
        "password" : passwordTextController.text
      };
     bool decider = await authService.loginUser(data, context);
     if(decider == true){
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => HomePage())
       );
     }
      setState(() {
        isLogged = false;
      });
  //  }
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
}
