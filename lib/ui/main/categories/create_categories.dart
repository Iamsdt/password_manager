import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/categories/categories_controller.dart';

class CreateCategories {
  static void showDialog(CategoriesController controller) {
    var text = "";

    Get.defaultDialog(
        title: "Create Category",
        titleStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
        content: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: TextField(
            onChanged: (string) {
              text = string;
            },
            decoration: InputDecoration(
              hintText: "Category name",
            ),
          ),
        ),
        confirm: MaterialButton(
          onPressed: () {
            print("OK");
            print(text);
            controller.createCategory(text);
            Get.back();
          },
          child: Text("OK"),
        ),
        cancel: MaterialButton(
          onPressed: () {
            print("Cancel");
            Get.back();
          },
          child: Text("CANCEL"),
        ),
        barrierDismissible: false,
        radius: 10.0);
  }
}
