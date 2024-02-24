import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{

  Future<bool> loginUser(data,context) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data["email"],
          password: data["password"]
      );
      return true;
    }
    catch (e){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text("Login failed"),
              content: const Text("Please try again later"),
            );
          }
      );
    }
    return false;
  }
}