import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/home/home_controller.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

class CreateNotes {
  static void showDialog(
    String uuid, {
    String noteUUID = "",
    String initValue = "",
    bool edit = false,
  }) {
    var text = initValue;

    Get.bottomSheet(
      Container(
        color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
        child: Wrap(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.white,
                      // ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
                    ),
                    child: TextFormField(
                      initialValue: initValue,
                      onChanged: (value) {
                        text = value;
                      },
                      maxLines: 10,
                      minLines: 2,
                      decoration: InputDecoration(
                        hintText: "Add notes",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          // borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.4,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    margin: const EdgeInsets.only(top: 20),
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
                              ? Colors.grey.shade900
                              : Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (text.isNotEmpty) {
                          if (edit) {
                            HomeController.to.updateNote(uuid, text, noteUUID);
                            Get.back();
                          } else {
                            HomeController.to.saveNote(uuid, text);
                            Get.back();
                          }
                        } else {
                          SnackBarHelper.showError("Text is empty");
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          edit ? "UPDATE" : "SAVE",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
