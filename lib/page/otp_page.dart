import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manzil/page/wrapper.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final String vid;
  final String phoneNumber;
  const OtpPage({super.key, required this.vid, required this.phoneNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();

}

class _OtpPageState extends State<OtpPage> {

  var code = '';


  String getPhoneNumber(){
    return widget.phoneNumber;
  }

  String getVid(){
    return widget.vid;
  }


  signIn() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: getVid(),
        smsCode: code);

    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((value){
        Get.offAll(() => const Wrapper());
      });
    }
    on FirebaseAuthException catch(e){
      Get.snackbar("Error Occurred", e.code);
    }
    catch(e){
      Get.snackbar("Error Occurred", e.toString());
    }
  }


  Widget button() {
    return Center(
      child: ElevatedButton(
        onPressed: (){
          signIn();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(16.0),
        ),

        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 90),
          child: Text(
            "Verify and Proceed",
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

  Widget textCode(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Pinput(
          length: 6,
          onChanged: (value){
            setState(() {
              code=value;
            });
          },
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: Navigator.of(context).pop,)
        ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: ListView(
          controller: ScrollController(),
          shrinkWrap: true,
          children: [
            Center(child: Image.asset("image/otp.png", height: 300, scale: 1.0)),
            const Center(child: Text("OTP Verification", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              child: Text("Enter OTP sent to +92 ${getPhoneNumber()}", textAlign: TextAlign.center)
            ),
            const SizedBox(height: 20),
            textCode(),
            const SizedBox(height: 20),
            button(),
          ],
        )
      )
    );
  }
}
