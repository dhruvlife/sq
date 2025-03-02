
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sq/screens/email_auth/login.dart';
import 'package:sq/utils/constants/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key});

  void forgetPassword(BuildContext context, String email, RxBool isLoading) async {
    if (email.isEmpty) {
      DUI.CustomAlertBox(context, "Enter an email to reset password");
    } else {
      try {
        isLoading(true);
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Get.snackbar("Success", "Email sent Successfully . . !",
              colorText: Colors.green, backgroundColor: Colors.black);
        Get.to(LoginScreen());

      } on FirebaseAuthException catch (e) {
        DUI.CustomAlertBox(context, e.code.toString());
      } finally {
        isLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    RxBool isLoading = false.obs;

    return Scaffold(
      body: Obx(() => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DUI.CustomTextField(emailController, "Email Address", Icons.mail, false),
                const SizedBox(
                  height: 20,
                ),
                DUI.CustomButton(() {
                  forgetPassword(context, emailController.text.toString(), isLoading);
                }, "Reset Password")
              ],
            ),
          ),
          if (isLoading.value)
            Container(
              color: Colors.black.withOpacity(0.5),
              child:  Center(
                child: LoadingAnimationWidget.inkDrop(color: Color.fromARGB(255, 1, 113, 4), size:50),
              ),
            ),
        ],
      )),
    );
  }
}
