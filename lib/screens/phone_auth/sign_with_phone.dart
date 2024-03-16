// import 'dart:math';

// import 'package:flutter_animated_button/flutter_animated_button.dart';
// import 'package:solvequery/home.dart';
// import 'package:solvequery/screens/phone_auth/verify_otp.dart';
// import 'package:solvequery/uihelper.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class PhoneSigninScreen extends StatefulWidget {
//   const PhoneSigninScreen({super.key});

//   @override
//   State<PhoneSigninScreen> createState() => _PhoneSigninScreenState();
// }

// class _PhoneSigninScreenState extends State<PhoneSigninScreen> {
//   TextEditingController phonenumController = TextEditingController();
//   void sendOTP() async {
//     String phone = "+91" + phonenumController.text.trim();
//     await FirebaseAuth.instance.verifyPhoneNumber(
//         verificationCompleted: (phoneCredential) {},
//         verificationFailed: (ex) {
//           DUI.CustomAlertBox(context, ex.code.toString());
//         },
//         codeSent: (verificattionId, resendToken) {
//            Navigator.push(context,
//               CupertinoPageRoute(builder: (context) =>  VerifyOtpScreen(verificationId: verificattionId)));
//         },
//         codeAutoRetrievalTimeout: (verificationId) {},
//         phoneNumber: phone);
//     Duration(seconds: 120);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Signin with phone no'),
//       ),
//       body: SafeArea(
//           child: ListView(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 45,
//                 ),
//                 TextField(
//                   controller: phonenumController,
//                   decoration: InputDecoration(
//                       labelText: "enter phone number",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12)))),
//                   keyboardType: TextInputType.phone,
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
                
//                 SizedBox(
//                   width: double.infinity,
//                   child: AnimatedButton(
//                     backgroundColor: Color.fromARGB(255, 255, 255, 255),
//                     textStyle: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w400),
//                     borderRadius: 12,
//                     selectedTextColor: Colors.green,
//                     selectedBackgroundColor: Color.fromARGB(255, 52, 52, 52),
//                     onPress: sendOTP,
//                     isReverse: true,
                    
//                     text: "save",
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       )),
//     );
//   }
// }




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sq/screens/phone_auth/verify_otp.dart';
import 'package:sq/utils/constants/uihelper.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class PhoneSigninScreen extends StatelessWidget {
  const PhoneSigninScreen({Key? key});

  void sendOTP(BuildContext context, TextEditingController phonenumController) async {
    String phone = "+91" + phonenumController.text.trim();
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (phoneCredential) {},
        verificationFailed: (ex) {
          DUI.CustomAlertBox(context, ex.code.toString());
        },
        codeSent: (verificationId, resendToken) {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => VerifyOtpScreen(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        phoneNumber: phone);
    Duration(seconds: 120);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController phonenumController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign in with phone no'),
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
                    maxLength: 10,
                    controller: phonenumController,
                    decoration: InputDecoration(
                        labelText: "enter phone number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)))),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: AnimatedButton(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      textStyle: TextStyle(
                          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
                      borderRadius: 12,
                      selectedTextColor: Colors.green,
                      selectedBackgroundColor: Color.fromARGB(255, 52, 52, 52),
                      onPress: () {
                        sendOTP(context, phonenumController);
                      },
                      isReverse: true,
                      text: "save",
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




/*
https://www.youtube.com/watch?v=LDzIMSXaKVo
 */