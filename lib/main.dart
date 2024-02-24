
import "dart:js";

import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:stock_management_akshaya_store/component/view/home_view.dart";
import "package:stock_management_akshaya_store/component/view/login.dart";
import "package:stock_management_akshaya_store/component/view/new_customer_view.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCRg-1_wqmh3fUcotTW0jSvCoP2Gr2vyxo",
        appId: "1:847763483235:web:72ca58e48e627f18ae6656",
        messagingSenderId: "847763483235",
        projectId: "akshaya-stores"
    )
  );
  Widget app = MaterialApp(
    initialRoute: "/home",
    routes: {
      "/login" : (context) => const LoginPage(),
      "/home" : (context) => const HomePage(),
      "/customerAdding" :(context) => const NewCustomerAddingPage()
    },
  );
  runApp(app);
}
