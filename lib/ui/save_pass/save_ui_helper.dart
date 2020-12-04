import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ext/ext.dart';

class SaveUIHelper {
  //input form
  static Container userInputBox(
    TextEditingController controller,
    String hint,
    bool obscureText,
    void click(),
  ) {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.8,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.black,
          ).materialClick(() {
            //change icon
            click();
          }),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  static Container getInputLebel(String text) {
    return Container(
      width: Get.width * 0.8,
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // save button
  static Widget saveButton(void onPressed()) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Get.width * 0.5,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF00B9FF),
            ),
            color: Color(0xFF00B9FF),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: MaterialButton(
            onPressed: () {
              onPressed();
            },
            child: Container(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
