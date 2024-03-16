
// import 'package:flutter/material.dart';
// import 'package:sq/app.dart';
// import 'package:sq/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   // Initialize Firebase
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const App());
// }

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sq/splash.dart';
import 'package:sq/utils/theme/theme.dart';
//import 'package:flutter/material.dart';
//import 'package:sq/app.dart';
import 'package:sq/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
    // Handle the initialization error gracefully, if needed
  }

  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Solvequery",
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      //  initialBinding: GeneralBindings(),
      home: SplashScreen(),
    );
  }
}