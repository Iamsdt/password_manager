import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/controller/card/card_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/main/cards/card_input_form.dart';
import 'package:password_manager/ui/shared/common_ui.dart';
import 'package:password_manager/ui/shared/my_card_widget.dart';
import 'package:password_manager/ext/ext.dart';

class CardPageUI extends StatelessWidget {
  final CardController controller = Get.put(getIt<CardController>());
  final Encrypter encrypter = Get.find(tag: "ENCRYPT");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "My Cards",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(CardInputPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 10),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 32,
              ),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
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
                    style: TextStyle(fontSize: 20, color: Colors.black38),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          GetX<CardController>(
            init: controller,
            initState: (_) {
              controller.getAllData();
            },
            builder: (_) {
              var data = controller.cardModelStatus.value;
              if (data.state == DataState.LOADED) {
                if (data.data.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(top: 50),
                      child: CommonUI.showFailed(
                        "No cards found",
                      ),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, pos) {
                      var model = data.data[pos];
                      var modelDe = model.copyWith(
                        cardNumber: model.cardNumber.decrypt(encrypter),
                        cvc: model.cvc.decrypt(encrypter),
                      );
                      return Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: MyCardWidget(modelDe),
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
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (ctx, pos) {
          //       var model =
          //       return MyCardWidget();
          //     },
          //     childCount: 10,
          //   ),
          // ),
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
