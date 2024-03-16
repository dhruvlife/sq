

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animated_button/flutter_animated_button.dart';
// import 'package:solvequery/home.dart';
// import 'package:solvequery/uihelper.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({Key? key}) : super(key: key);

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   Future<void> signup() async {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     if (email == "" || password == "") {
//       DUI.CustomAlertBox(context, "Please enter required field");
//     } else {
//       try {
//         final UserCredential userCredential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailController.text.trim(),
//           password: passwordController.text.trim(),
//         );
//         Navigator.push(
//           context,
//           CupertinoPageRoute(builder: (context) => const HomeScreen()),
//         );

//         // User successfully signed up
//         print('User signed up: ${userCredential.user!.email}');
//       } on FirebaseAuthException catch (e) {
//         DUI.CustomAlertBox(context, e.code.toString());
//         if (e.code == 'weak-password') {
//           print('The password provided is too weak.');
//         } else if (e.code == 'email-already-in-use') {
//           print('The account already exists for that email.');
//         }
//       } catch (e) {
//         print('Error: $e');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Signup'),
//       ),
//       body: SafeArea(
//         child: ListView(
//           padding: const EdgeInsets.all(20.0),
//           children: [
//             const SizedBox(height: 20),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email Address'),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: AnimatedButton(
//                 textStyle: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w400),
//                 borderRadius: 12,
//                 selectedTextColor: Colors.green,
//                 selectedBackgroundColor: const Color.fromARGB(255, 52, 52, 52),
//                 onPress: signup,
//                 text: "Sign Up",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:sq/home.dart';
import 'package:sq/utils/constants/uihelper.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      DUI.CustomAlertBox(Get.context!, "Please enter required fields");
    } else if (password != confirmPassword) {
      DUI.CustomAlertBox(Get.context!, "Passwords do not match");
      
    } else {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.offAll(() => HomeScreen());
        print('User signed up: ${userCredential.user!.email}');
      } on FirebaseAuthException catch (e) {
        DUI.CustomAlertBox(Get.context!, e.code.toString());
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}

class SignupScreen extends StatelessWidget {
  final SignupController _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Signup'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _signupController.emailController,
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            const SizedBox(height: 20),
            Obx(() => TextField(
                  controller: _signupController.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _signupController.obscurePassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        _signupController.obscurePassword.toggle();
                      },
                    ),
                  ),
                  obscureText: _signupController.obscurePassword.value,
                )),
            const SizedBox(height: 20),
            Obx(() => TextField(
                  controller: _signupController.confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _signupController.obscureConfirmPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        _signupController.obscureConfirmPassword.toggle();
                      },
                    ),
                  ),
                  obscureText: _signupController.obscureConfirmPassword.value,
                )),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: AnimatedButton(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
                borderRadius: 12,
                selectedTextColor: Colors.green,
                selectedBackgroundColor: const Color.fromARGB(255, 52, 52, 52),
                onPress: _signupController.signup,
                text: "Sign Up",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
















