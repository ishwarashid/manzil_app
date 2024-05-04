import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manzil/page/phone_auth_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  Widget phoneButton() {
    return Center(
      child: ElevatedButton(
        onPressed: (){
            Get.to(() => const PhoneAuthPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(12.0),
        ),

        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
             "Sign in with Phone",
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

  // Widget googleButton(){
  //   return  ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: Colors.white,
  //       foregroundColor: Colors.black,
  //     ),
  //     onPressed: () {},
  //         child: const Row(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Image(
  //               image: AssetImage("image/google_logo.png"),
  //               height: 20.0,
  //               width: 24,
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(left: 24, right: 8, top: 10, bottom: 10),
  //               child: Text(
  //                 'Sign in with Google',
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   color: Colors.black54,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       // ),]
  //     // ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Image.asset("image/main_page.jpg"),
            const SizedBox(height: 30),
            const Text("Sign in to your account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 60),
            phoneButton(),
            // const SizedBox(height: 30),
            // googleButton()
          ],
        )
    );
  }
}
