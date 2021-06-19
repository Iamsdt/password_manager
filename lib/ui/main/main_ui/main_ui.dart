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
import 'package:password_manager/ext/ext.dart';

class HomePageUI extends StatelessWidget {
  final HomeController controller =
      Get.put(getIt<HomeController>(), permanent: true);

  final Encrypter encrypter = Get.find(tag: "ENCRYPT");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
              top: 40 + kToolbarHeight,
              bottom: 20,
            ),
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
                    hintText: "Search ...",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'Recent Site',
                textAlign: TextAlign.left,
                style: context.textThemeData.headline5,
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
                return showLoadedData(context, data.data);
              } else {
                return getSliver(
                  CommonUI.showLoading(),
                );
              }
            },
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20),
          ),
        ],
      ),
    );
  }

  Widget getSliver(Widget child) {
    return SliverToBoxAdapter(
      child: child,
    );
  }

  Widget showLoadedData(BuildContext context, List<PasswordModel> data) {
    if (data.isEmpty) {
      return getSliver(
        Container(
          margin: EdgeInsets.only(top: 50),
          child: CommonUI.showFailed(
            "No saved password found",
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, pos) {
          var model = data[pos];
          return Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: ListItemUI.passList(context, model, encrypter),
          );
        },
        childCount: data.length,
      ),
    );
  }
}
