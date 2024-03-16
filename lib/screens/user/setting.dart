import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sq/popup.dart';
import 'package:sq/privacypolicy.dart';
import 'package:sq/screens/chatbot/screen_nav_chatbot.dart';
import 'package:sq/screens/user/change_password.dart';
import 'package:sq/screens/user/profile.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
       title: const Text(
                "Settings",
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    color: Colors.green,
                    fontWeight: FontWeight.w500),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
  
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the desired screen here
                      Get.to(ProfileScreen());
                    },
                    child: Container(
                      width: Get.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Iconsax.user_edit,
                              size: 28,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(ChangePassword());
                      // Navigate to the desired screen here
                      
                    },
                    child: Container(
                      width: Get.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.password,
                              size: 28,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "Change passsword",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the desired screen here
                     Get.to(ReviewScreen());
                    },
                    child: Container(
                      width: Get.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.reviews,
                              size: 28,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "Reviews",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the desired screen here
                     Get.to(PrivacyPolicyPage());
                    },
                    child: Container(
                      width: Get.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.security,
                              size: 28,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "Privacy policy",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the desired screen here
                      Get.to(const ChatScreen());
                    },
                    child: Container(
                      width: Get.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.help,
                              size: 28,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "Help",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the desired screen here
                      
                    },
                    child: Container(
                      width: Get.width * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Iconsax.user_add,
                              size: 28,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "Invite a friend",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.amber,
//                         borderRadius: BorderRadius.circular(1),
//                       ),
//                     ),
// child: Icon(Iconsax.user),


