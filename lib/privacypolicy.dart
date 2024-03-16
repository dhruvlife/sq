import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(centerTitle: true,
       title: const Text(
                "Privacy Policy",
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    color: Colors.green,
                    fontWeight: FontWeight.w500),
              ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Section title color
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'We collect personal information such as your name and email address when you sign in to our app. We may also collect device information such as your IP address and device type.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'How We Use Your Information',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Section title color
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'We use your personal information to provide and improve our services. This may include communicating with you, providing customer support, and personalizing the content you see.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Changes to Our Privacy Policy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.green, // Section title color
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'We may update our privacy policy from time to time. Any changes will be reflected on this page. We encourage you to review our privacy policy periodically for any updates.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
