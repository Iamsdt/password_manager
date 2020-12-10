import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveUIHelper {
  //input form
  static Widget userInputBox(TextEditingController controller, String hint) {
    return ObxValue(
      (data) => Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 0.0,
        color: Get.isDarkMode ? Colors.white30 : Colors.white,
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.blue[200],
          validator: (value) => value.isNotEmpty && value.length >= 6
              ? null
              : "Enter valid password (min length: 6)",
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.blue[500],
              size: 20,
            ),
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                data.value = !data.value;
              },
              child: Icon(
                data.value ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          obscureText: data.value,
        ),
      ),
      false.obs,
    );
  }

  static Container getInputLebel(String text) {
    return Container(
      width: Get.width * 0.8,
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(
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
                color: Get.isDarkMode
                    ? Colors.grey[900]
                    : Colors.grey.withOpacity(0.4),
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
