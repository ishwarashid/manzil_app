import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manzil/page/start_page.dart';
import 'package:manzil/util/user_database.dart';

class PassengerPage extends StatefulWidget {

  const PassengerPage({super.key});

  @override
  State<PassengerPage> createState() => _PassengerPageState();
}

class _PassengerPageState extends State<PassengerPage> {
  var firstName = "";
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final _userDB = UserDatabase();
  final user = FirebaseAuth.instance.currentUser;

  getPhoneNumber() {
    return user!.phoneNumber;
  }

  Widget userInfoField(String label, TextEditingController controller) {
    return TextField(
      cursorColor: Colors.green,
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: label,
          hintStyle: const TextStyle(color: Colors.grey),
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green))),
    );
  }

  void checkUserExistence() async {
    var exists = await _userDB.userExists(user!.phoneNumber.toString());
    var userData = await _userDB.getUser(user!.phoneNumber.toString());
    if (exists) {
      setState(() {
        firstName = userData!["firstName"];
      });
      return;
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => SizedBox(
        height: 200,
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text("Enter your details"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                userInfoField("First Name", _firstNameController),
                const SizedBox(height: 20),
                userInfoField("Last Name", _lastNameController),
                const SizedBox(height: 20),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  if (_firstNameController.text.isEmpty &&
                      _lastNameController.text.isEmpty) {
                    Get.snackbar("Empty Fields!", "Please enter your details",
                        colorText: Colors.red);
                    return;
                  }

                  if(!context.mounted) return;

                  Navigator.of(context).pop();

                  setState(() {
                    firstName = _firstNameController.text;
                  });

                  _userDB.saveUser(_firstNameController.text,
                      _lastNameController.text, getPhoneNumber());

                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text("Save",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    checkUserExistence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text("Welcome $firstName")),
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut().then((value) {
              Get.to(() => const StartPage());
            });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              foregroundColor: MaterialStateProperty.all(Colors.white)),
          child: const Text("Sign Out"),
        )
      ],
    ));
  }
}
