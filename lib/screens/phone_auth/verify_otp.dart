// import 'package:solvequery/home.dart';
// import 'package:solvequery/uihelper.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class VerifyOtpScreen extends StatefulWidget {
//   final String verificationId;
//   const VerifyOtpScreen({super.key, required this.verificationId});

//   @override
//   State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
// }

// class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
//   TextEditingController otpController = TextEditingController();
//   void verifyOtp() async {
//     String otp = otpController.text.trim();
//     PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
//         verificationId: widget.verificationId, smsCode: otp);
//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(phoneCredential);
//       DUI.CustomAlertBox(context, "login successfully");
//       if (userCredential.user != "") {
//         Navigator.pushReplacement(
//             context, CupertinoPageRoute(builder: (context) => HomeScreen()));
//       }
//     } on FirebaseAuthException catch (ex) {
//       DUI.CustomAlertBox(context, ex.code.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Verify Otp'),
//       ),
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 25),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 45,
//                   ),
//                   TextField(
//                     maxLength: 6,
//                     controller: otpController,
//                     decoration: InputDecoration(
//                         labelText: "enter otp",
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(12)))),
//                     keyboardType: TextInputType.number,
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   SizedBox(
//                     width: 200,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         verifyOtp();
//                       },
//                       child: Text('Verify'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sq/home.dart';
import 'package:sq/utils/constants/uihelper.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String verificationId;

  const VerifyOtpScreen({Key? key, required this.verificationId})
      : super(key: key);

  void verifyOtp(
    BuildContext context, TextEditingController otpController) async {
    String otp = otpController.text.trim();
    PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneCredential);

      if (userCredential.user != null) {
        Get.off(() => HomeScreen());
        Get.snackbar("S u c c e s s", "login Successfully...",
            colorText: Color.fromRGBO(76, 164, 0, 1),
            backgroundColor: Color.fromARGB(188, 0, 0, 0));
      }
    } on FirebaseAuthException catch (ex) {
      DUI.CustomAlertBox(context, ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Verify Otp'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  TextField(
                    maxLength: 6,
                    controller: otpController,
                    decoration: InputDecoration(
                        labelText: "enter otp",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        verifyOtp(context, otpController);
                      },
                      child: Text('Verify'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
