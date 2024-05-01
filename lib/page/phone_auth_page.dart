import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'otp_page.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {

  final TextEditingController _phoneController = TextEditingController();
  

  sendCode() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+92${_phoneController.text}",
          verificationCompleted: (PhoneAuthCredential credential){},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar("Error Occurred", e.code);
          },
          codeSent: (String vid, int? token) {
            Get.to(OtpPage(vid: vid, phoneNumber: _phoneController.text));
          },
          codeAutoRetrievalTimeout: (vid){}
      );
    }
    on FirebaseAuthException catch(e) {
      Get.snackbar("Error Occurred", e.code);
    }
    catch(e){
      Get.snackbar("Error Occurred", e.toString());
    }
  }
  
  
  Widget phoneText(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: TextField(
          cursorColor: Colors.green,
          controller: _phoneController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefix: Text("+92 "),
            prefixIcon: Icon(Icons.phone),
            labelText: "Enter Phone Number",
            hintStyle: TextStyle(color: Colors.grey),
            labelStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green)
            )
          ),
        ),
    );
  }

 Widget button() {
    return Center(
      child: ElevatedButton(
        onPressed: (){
          sendCode();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(16.0),
        ),

        child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 90),
          child: Text(
            "Receive OTP",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: Navigator.of(context).pop,)
      ),
      body: ListView(
        controller: ScrollController(),
        shrinkWrap: true,
        children: [
          Center(child: Image.asset("image/otp.png", height: 300, scale: 1.0)),
          const Center(
            child: Text(
                "Verify Your Phone!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                )
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 6)),
          const SizedBox(height: 20),
          phoneText(),
          const SizedBox(height: 50),
          button(),
        ],
      )
    );
  }
}
