

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:sq/screens/user/forgetpassword.dart';
import 'package:sq/home.dart';
import 'package:sq/screens/email_auth/signup.dart';
import 'package:sq/screens/phone_auth/sign_with_phone.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool obscurePassword = true.obs;
  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("No Internet", "Please check your internet connection",
          colorText: Colors.red, backgroundColor: Colors.black);
    }
  }

  void login() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("No Internet", "Please check your internet connection",
          colorText: Colors.red, backgroundColor: Colors.black);
      return;
    }

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter required fields",
          colorText: Colors.red, backgroundColor: Colors.black);
    } else {
      try {
        isLoading(true);
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (userCredential.user != null) {
          Get.offAll(() => HomeScreen());
          Get.snackbar("Success", "Login Successful",
              colorText: Colors.green, backgroundColor: Colors.black);
        }
      } on FirebaseAuthException catch (ex) {
        Get.snackbar("Error", ex.message!,
            colorText: Colors.red, backgroundColor: Colors.black);
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> handleSignIn() async {
    try {
      isLoading(true);
      await googleSignIn.signOut(); // Ensure previous session is cleared
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential authResult =
            await _auth.signInWithCredential(credential);

        if (authResult.user != null) {
          Get.offAll(() => HomeScreen());
          Get.snackbar("Success", "Google Sign-in Successful",
              colorText: Colors.green, backgroundColor: Colors.black);
        }
      }
    } catch (error) {
      print(error);
      Get.snackbar("Error", "An error occurred",
          colorText: Colors.red, backgroundColor: Colors.black);
    } finally {
      isLoading(false);
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
    print("User signed out from Google account");
  }

  void goToSignUp() {
    Get.to(() => SignupScreen());
  }

  void goToPhoneSignIn() {
    Get.to(() => const PhoneSigninScreen());
  }
}

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Obx(() => Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              children: [
                const SizedBox(height: 25),
                TextField(
                  controller: _loginController.emailController,
                  decoration: const InputDecoration(labelText: "Email Address"),
                ),
                const SizedBox(height: 15),
                Obx(
                  () => TextField(
                    controller: _loginController.passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _loginController.obscurePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          _loginController.obscurePassword.toggle();
                        },
                      ),
                    ),
                    obscureText: _loginController.obscurePassword.value,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loginController.isLoading.value
                        ? null
                        : _loginController.login,
                    child: _loginController.isLoading.value
                        ? LoadingAnimationWidget.staggeredDotsWave(color: Colors.green, size: 30)
                        : const Text('Login'),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => const ForgetPassword());
                      },
                      child: const Text(
                        'Forgot password ?',
                        style: TextStyle(color: Color.fromARGB(255, 95, 95, 95),fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: _loginController.goToSignUp,
                      child: const Text(
                        'Create Account',
                        style: TextStyle(color: Color.fromARGB(255, 95, 95, 95),fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or sign in with',
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(15), // Adjust the radius as needed
                  ),
                  child: TextButton.icon(
                    onPressed: _loginController.isLoading.value
                        ? null
                        : _loginController.handleSignIn,
                    icon: const Image(
                      image: AssetImage('assets/logos/google-icon.png'),
                      height: 30.0,
                      width: 30.0,
                    ),
                    label: const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_loginController.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child:LoadingAnimationWidget.fourRotatingDots(color: Colors.pinkAccent, size: 60) ,
                  //CircularProgressIndicator(),
                ),
              ),
          ],
        )),
      ),
    );
  }
}
