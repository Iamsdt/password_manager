import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/controller/card/card_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/main/cards/card_input_form.dart';
import 'package:password_manager/ui/shared/common_ui.dart';
import 'package:password_manager/ui/shared/my_card_widget.dart';

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
          style: TextStyle(
            color: context.theme.textTheme.bodyText1?.color,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(CardInputPage("Add new cards", false, null));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 10),
              child: Icon(
                Icons.add,
                color: context.theme.iconTheme.color,
                size: 32,
              ),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white12,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.black.withOpacity(0.1),
                ),
                child: TextFormField(
                  onChanged: (value) {
                    controller.filterList(value);
                  },
                  focusNode: controller.focusNode,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blue[500],
                    ),
                    hintText: "Search ... (card holder name)",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          showCardList(),
        ],
      ),
    );
  }

  //show card list
  Widget showCardList() {
    return GetX<CardController>(
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

                return InkWell(
                  onLongPress: () {
                    Get.to(CardInputPage("Update Card", true, modelDe));
                    controller.removeFocus();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: MyCardWidget(modelDe),
                  ),
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
      },
    );
  }
}
