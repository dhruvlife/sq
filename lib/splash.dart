// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:solvequery/home.dart';

// import 'screens/email_auth/login.dart';

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<SplashController>(
//         init: SplashController(),
//         builder: (controller) {
//           return AnimatedOpacity(
//             opacity: controller.animation.value,
//             duration: Duration(seconds: 2),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.blue,
//                     Colors.purple,
//                   ],
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   'SolveQuery',
//                   style: TextStyle(
//                     fontSize: 32.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class SplashController extends GetxController
//     with SingleGetTickerProviderMixin {
//   late AnimationController animationController;
//   late Animation<double> animation;

//   @override
//   void onInit() {
//     animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2), // Change the duration as needed
//     );
//     animation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

//     animationController.forward();
//     super.onInit();
//     whereToGo();
//   }

//   @override
//   void onClose() {
//     animationController.dispose();
//     super.onClose();
//   }

//   void whereToGo(){
//     Timer(
//       const Duration(seconds: 3),
//       () {
//         if (FirebaseAuth.instance.currentUser != null) {
//           Get.offAll(() => HomeScreen());
//         }
//         else{
//           Get.offAll(() => LoginScreen());
//         }
//       }

//     );
//   }
// }

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sq/home.dart';
import 'package:sq/screens/email_auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  static const String keylogin = "login";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1, end: 4).animate(_controller);

    _controller.forward();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/animations/splashy.gif',
                    height: 380, // Increased height by 20%
                    width: 380,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GradientTextAnimation(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void whereToGo() async {
  //   var sharedPref = GetStorage();
  //   await sharedPref.initStorage;
  //   var isLogin = sharedPref.read(keylogin);

  //   debugPrint("""Let's print the bool values\n
  //   1) Is login: $isLogin\n""");

  //   Timer(
  //     const Duration(seconds: 3),
  //     () {
  //       if (FirebaseAuth.instance.currentUser != null) {
  //         Get.offAll(()=>HomeScreen());

  //       } else {
  //         Get.offAll(() => LoginScreen());
  //       }
  //     },
  //   );
  // }
  void whereToGo() async {
    var sharedPref = GetStorage();
    await sharedPref.initStorage;
    var isLogin = sharedPref.read(keylogin);

    debugPrint("""Let's print the bool values\n
    1) Is login: $isLogin\n""");

    Timer(
      const Duration(seconds: 4),
      () {
        if (FirebaseAuth.instance.currentUser != null) {
          Get.offAll(() => HomeScreen());
        } else {
          // Check if isLogin is not null and is true
          if (isLogin != null && isLogin) {
            Get.offAll(() => HomeScreen());
          } else {
            Get.offAll(() => LoginScreen());
          }
        }
      },
    );
  }
}


class GradientTextAnimation extends StatefulWidget {
  @override
  _GradientTextAnimationState createState() => _GradientTextAnimationState();
}

class _GradientTextAnimationState extends State<GradientTextAnimation> {
  List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  int _currentColorIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start the animation loop
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        // Change the color index
        _currentColorIndex = (_currentColorIndex + 1) % _colors.length;
        // Restart animation loop
        _startAnimation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _colors[_currentColorIndex],
            _colors[(_currentColorIndex + 1) % _colors.length],
          ],
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            '  Solve Query  ',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w400,
              
            ),
          ),
        ),
      ),
    );
  }
}