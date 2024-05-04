import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserDatabase{
  final db = FirebaseFirestore.instance;

  saveUser(String firstName, String lastName, String phoneNumber) {

    Map<String, String> user = {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber
    };

    db.collection("users").add(user).whenComplete(() => Get.snackbar("Success", "Details saved.", colorText: Colors.green, backgroundColor: Colors.white));
  }

   Future<bool> userExists(String phoneNumber) async {
    var querySnapshot = await db.collection("users").where("phoneNumber", isEqualTo: phoneNumber).get();
    if(querySnapshot.docs.isEmpty){
      return false;
    }
    else{
      return true;
    }
  }

  Future<Map<String, dynamic>?> getUser(String phoneNumber) async {
    var querySnapshot = await db.collection("users").where("phoneNumber", isEqualTo: phoneNumber).get();
    if(querySnapshot.docs.isEmpty){
      return null;
    }
    else{
      return querySnapshot.docs.first.data();
    }
  }

}
