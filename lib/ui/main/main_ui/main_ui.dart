import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/controller/home/home_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/shared/common_ui.dart';
import 'package:password_manager/ui/shared/list_item.dart';
import 'package:password_manager/ext/ext.dart';

class HomePageUI extends StatelessWidget {
  final HomeController controller = Get.put(getIt<HomeController>());
  final Encrypter encrypter = Get.find(tag: "ENCRYPT");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40 + kToolbarHeight,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
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
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
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
          ),
          GetX<HomeController>(
            init: controller,
            initState: (_) {
              controller.getAllData();
            },
            builder: (_) {
              var data = controller.passwordModelStatus.value;

              if (data.state == DataState.LOADED) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, pos) {
                      var model = data.data[pos];
                      var modelDe = model.copyWith(
                          userName: model.userName.decrypt(encrypter),
                          password: model.password.decrypt(encrypter));
                      return Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: ListItemUI.passList(modelDe),
                      );
                    },
                    childCount: data.data.length,
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: CommonUI.showLoading(),
                );
              }

              // switch (data.state) {
              //   case DataState.INIT:
              //   case DataState.LOADING:
              //     return CommonUI.showLoading();
              //   case DataState.NO_INTERNET:
              //     return CommonUI.showOffline();
              //   case DataState.LOADED:
              //     return SliverList(
              //       delegate: SliverChildBuilderDelegate(
              //         (ctx, pos) {
              //           var model = data.data[pos];
              //           return Container(
              //             margin: EdgeInsets.only(top: 10, bottom: 10),
              //             child: ListItemUI.passList(model),
              //           );
              //         },
              //         childCount: data.data.length,
              //       ),
              //     );
              //   case DataState.FAILED:
              //     return CommonUI.showFailed(
              //         "Something went wrong! Please try again");
              //   default:
              //     return Container();
              // }
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
