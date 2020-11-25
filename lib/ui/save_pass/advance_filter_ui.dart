import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvanceFilterUI extends StatefulWidget {
  @override
  _SavePasswordState createState() => _SavePasswordState();
}

class _SavePasswordState extends State<AdvanceFilterUI> {
  bool isNumbers = true;
  bool prefixTextValue = false;

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
                  ),
                )
              ],
            ),
            CheckboxListTile(
              title: Text(
                "Add prefix text",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: prefixTextValue,
              onChanged: (value) {
                setState(() {
                  prefixTextValue = value;
                });
              },
            ),
            Visibility(
              visible: prefixTextValue,
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Prefix text"
                  ),
                ),
              ),
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
                  SwitchListTile(
                    title: getTitle("Add Uppercase Letter"),
                    value: isNumbers,
                    onChanged: (value) {
                      setState(() {
                        isNumbers = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: getTitle("Add Lowercase Letter"),
                    value: isNumbers,
                    onChanged: (value) {
                      setState(() {
                        isNumbers = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: getTitle("Add Numbers"),
                    value: isNumbers,
                    onChanged: (value) {
                      setState(() {
                        isNumbers = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: getTitle("Add Special charters"),
                    value: isNumbers,
                    onChanged: (value) {
                      setState(() {
                        isNumbers = value;
                      });
                    },
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
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      // _loginController.requestLogin();
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
