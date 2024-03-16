// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class PhoneAuthScreen extends StatefulWidget {
//   @override
//   _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
// }

// class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
//   late String _verificationId;

//   Future<void> _verifyPhone() async {
//     PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential phoneAuthCredential) async {
//       await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
//       // Navigate to the next screen upon successful verification
//     };

//     PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException authException) {
//       print('Error: $authException');
//     };

//     PhoneCodeSent codeSent =
//         (String verificationId, [int? forceResendingToken]) async {
//       // Save the verification ID for later use
//       _verificationId = verificationId;
//     };

//     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       // Auto retrieval time out, handle errors or retry
//     };

//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: '+1234567890', // Your phone number to be verified
//         timeout: const Duration(seconds: 60),
//         verificationCompleted: verificationCompleted,
//         verificationFailed: verificationFailed,
//         codeSent: codeSent,
//         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//       );
//     } catch (e) {
//       print("Failed to Verify Phone: $e");
//     }
//   }

//   void _signInWithPhoneNumber(String smsCode) async {
//     try {
//       PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: smsCode,
//       );
//       await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
//       // Navigate to the next screen upon successful sign-in
//     } catch (e) {
//       print("Failed to Sign In: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Authentication'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _verifyPhone,
//           child: Text('Verify Phone Number'),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatelessWidget {
  late String _verificationId;

  Future<void> _verifyPhone(BuildContext context) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      // Navigate to the next screen upon successful verification
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('Error: $authException');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      // Save the verification ID for later use
      _verificationId = verificationId;
      // Navigate to the next screen to input SMS code
      // Here, you would typically navigate to another screen to input the code
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // Auto retrieval time out, handle errors or retry
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+1234567890', // Your phone number to be verified
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print("Failed to Verify Phone: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _verifyPhone(context),
          child: const Text('Verify Phone Number'),
        ),
      ),
    );
  }
}
