import "dart:js";

import "package:flutter/material.dart";
import "package:stock_management_akshaya_store/view/login.dart";

void main(){
  Widget app = MaterialApp(
    initialRoute: "/login",
    routes: {
      "/login" : (context) => const LoginPage()
    },
  );
  runApp(app);
}
