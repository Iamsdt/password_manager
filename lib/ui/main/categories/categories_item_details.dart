import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/controller/categories/categories_controller.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/shared/common_ui.dart';
import 'package:password_manager/ui/shared/list_item.dart';

class CategoriesDetails extends StatelessWidget {
  final String uuid;

  const CategoriesDetails(this.uuid, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.share,
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 10),
              child: Icon(
                FontAwesomeIcons.trashAlt,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: GetX<CategoriesController>(
          init: getIt<CategoriesController>(),
          initState: (_) {},
          builder: (CategoriesController ctl) {
            var data = ctl.passwordModelStatus.value;
            switch (data.state) {
              case DataState.INIT:
              case DataState.LOADING:
                return CommonUI.showLoading();
              case DataState.NO_INTERNET:
                return CommonUI.showOffline();
              case DataState.LOADED:
                return ListView.builder(
                  itemCount: data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var model = data.data[index];
                    return ListItemUI.passList(model);
                  },
                );
              case DataState.FAILED:
                return CommonUI.showFailed(
                    "Something went wrong! Please try again");
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
