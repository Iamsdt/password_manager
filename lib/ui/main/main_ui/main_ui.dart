import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/controller/home/home_controller.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/shared/common_ui.dart';
import 'package:password_manager/ui/shared/list_item.dart';

class HomePageUI extends StatelessWidget {
  final HomeController controller =
      Get.put(getIt<HomeController>(), permanent: true);
  final Encrypter encrypter = Get.find(tag: "ENCRYPT");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40 + kToolbarHeight,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white12,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.black.withOpacity(0.1),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Search ...",
                    style: TextStyle(
                      fontSize: 20,
                      color: context.theme.hintColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Recent Site',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
            GetX<HomeController>(
              init: controller,
              initState: (_) {
                controller.getAllData();
              },
              builder: (_) {
                var data = controller.passwordModelStatus.value;
                if (data.state == DataState.LOADED) {
                  return showLoadedData(data.data);
                } else {
                  return CommonUI.showLoading();
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
          ],
        )),
      ),
    );
  }

  Widget showLoadedData(List<PasswordModel> data) {
    if (data.isEmpty) {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: CommonUI.showFailed(
          "No saved password found",
        ),
      );
    }

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, pos) {
          var model = data[pos];
          return Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: ListItemUI.passList(model, encrypter),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
