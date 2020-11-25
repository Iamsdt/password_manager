import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/save_pass/advance_filter_ui.dart';
import 'package:password_manager/ui/save_pass/save_password.dart';

class SheetUIHelper {
  static Widget showGenerateUI() {
    AppController _controller = Get.find(tag: "APP");

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      width: Get.width,
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Generate Secure Password",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.blue.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GetX(
                                init: _controller,
                                builder: (_) {
                                  var value = _controller.genPassword.value;
                                  print("UI ->" + value.pass);
                                  return Text(
                                    value.pass,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black38,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                _controller.updatePassword();
                              },
                              child: Icon(
                                Icons.sync,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        var value = _controller.genPassword.value.pass;
                        Clipboard.setData(new ClipboardData(text: value));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.blue,
                        ),
                        child: Text(
                          "COPY",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.fence,
                            color: Colors.blue,
                          ),
                          Text(
                            "ADVANCE OPTIONS",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ).materialClick(() {
                      Get.off(AdvanceFilterUI());
                    }),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.save_rounded,
                            color: Colors.blue,
                          ),
                          Text(
                            "SAVE",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ).materialClick(() {
                      Get.off(SavePasswordUI());
                    })
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
