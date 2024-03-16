import 'package:flutter/material.dart';

class DUI {
  static CustomTextField(TextEditingController controller, String text,
      IconData iconData, bool toHide) {
    return TextField(
      style: TextStyle(color: Color.fromARGB(255, 71, 71, 71)),
      controller: controller,
      obscureText: toHide,
      obscuringCharacter: '#',
      decoration: InputDecoration(
        hintText: text,
        suffixIcon: Icon(iconData),
      ),
    );
  }

  static CustomButton(VoidCallback voidCallback, String text) {
    return SizedBox(
      height: 55,
      width: 225,
      child: ElevatedButton(
        onPressed: () {
          voidCallback();
        },
        style: ElevatedButton.styleFrom(
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  static Future<void> CustomAlertBox(BuildContext context, String text) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(237, 255, 255, 255),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical:4),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 97, 6, 0),
              ),
            ),
          ),
          actions: [
            Center(
              child: OutlinedButton(
                
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
