import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/shared/modal_sheet.dart';

class AdvanceFilterUI extends StatelessWidget {
  var isNumbers = true.obs;
  var isUppercase = true.obs;
  var isLowercase = true.obs;
  var isSpecial = true.obs;
  var prefixTextValue = false.obs;
  String length = "16";

  AppController _appController = Get.find(tag: "APP");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Advance Filters",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.close,
            color: Colors.blue,
            size: 28,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Password Length:",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "default: 16",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      length = value;
                    },
                  ),
                )
              ],
            ),
            ObxValue(
              (data) => CheckboxListTile(
                title: Text(
                  "Add prefix text",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: prefixTextValue.value,
                onChanged: (value) {
                  prefixTextValue.value = value;
                },
              ),
              prefixTextValue,
            ),
            ObxValue(
              (data) => Visibility(
                visible: data.value,
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Prefix text"),
                  ),
                ),
              ),
              prefixTextValue,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.black.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  ObxValue(
                    (data) => SwitchListTile(
                      title: getTitle("Add Uppercase Letter"),
                      value: isUppercase.value,
                      onChanged: (value) {
                        isUppercase.value = value;
                      },
                    ),
                    isUppercase,
                  ),
                  ObxValue(
                    (data) => SwitchListTile(
                      title: getTitle("Add Lowercase Letter"),
                      value: isLowercase.value,
                      onChanged: (value) {
                        isLowercase.value = value;
                      },
                    ),
                    isLowercase,
                  ),
                  ObxValue(
                    (data) => SwitchListTile(
                      title: getTitle("Add Numbers"),
                      value: isNumbers.value,
                      onChanged: (value) {
                        isNumbers.value = value;
                      },
                    ),
                    isNumbers,
                  ),
                  ObxValue(
                    (data) => SwitchListTile(
                      title: getTitle("Add Special charters"),
                      value: isSpecial.value,
                      onChanged: (value) {
                        isSpecial.value = value;
                      },
                    ),
                    isSpecial,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.7,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                      // _loginController.requestLogin();
                      _appController.updatePassword(
                        length: length.toInt(),
                        isLowerCase: isLowercase.value,
                        isNumbers: isNumbers.value,
                        isUpperCase: isUppercase.value,
                        isSpecial: isSpecial.value,
                      );
                      Get.back();
                      //show bottom sheet again
                      Get.bottomSheet(SheetUIHelper.showGenerateUI());
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        "REGENERATE",
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
            ),
          ],
        ),
      ),
    );
  }

  Widget getTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
      ),
    );
  }
}
