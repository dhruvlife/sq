
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sq/screens/email_auth/login.dart';
import 'package:sq/screens/user/logout.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  late User? user;

  @override
  void onInit() {
    super.onInit();
    user = FirebaseAuth.instance.currentUser;
    loadUserData();
  }

  void loadUserData() {
    if (user != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          nameController.text = documentSnapshot['name'];
          emailController.text = documentSnapshot['email'];
          birthDateController.text = documentSnapshot['birthdate'];
          phoneNumberController.text = documentSnapshot['phoneNumber'];
          cityController.text = documentSnapshot['city'];
        }
      });
    }
  }

  void saveUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String birthdate = birthDateController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String city = cityController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        birthdate.isEmpty ||
        phoneNumber.isEmpty ||
        city.isEmpty) {
      Get.snackbar("E r r o r . . .", "Please enter required fields",
          colorText: Color.fromARGB(255, 255, 75, 75),
          backgroundColor: Color.fromARGB(188, 0, 0, 0));
    } else {
      Map<String, dynamic> userData = {
        "name": name,
        "email": email,
        "birthdate": birthdate,
        "phoneNumber": phoneNumber,
        "city": city,
      };
      if (user != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .set(userData);
        showToast("User data saved successfully!");
      }
    }
  }

  static void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginScreen());
  }

  static void logoutAlert(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(240, 255, 255, 255),
          title: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.offAll(() => const LogoutScreen());
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: _profileController.nameController,
                  decoration: const InputDecoration(
                    labelText: "Enter your name",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _profileController.emailController,
                  decoration: const InputDecoration(
                    labelText: "Enter your e-mail address",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  readOnly: true,
                  controller: _profileController.birthDateController,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null && picked != DateTime.now())
                      _profileController.birthDateController.text =
                          picked.toString();
                  },
                  decoration: const InputDecoration(
                    labelText: "Select your birth date",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  autofillHints : const <String>["6665554443"],
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  controller: _profileController.phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: "Enter your phone number",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _profileController.cityController,
                  decoration: const InputDecoration(
                    labelText: "Enter your city",
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: AnimatedButton(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                    borderRadius: 12,
                    selectedTextColor: Colors.green,
                    selectedBackgroundColor:
                        const Color.fromARGB(255, 52, 52, 52),
                    onPress: _profileController.saveUser,
                    text: "Save",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        ProfileController.logoutAlert(
                            context, "Confirm for going logout");
                      },
                      child: const Text("Logout")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
