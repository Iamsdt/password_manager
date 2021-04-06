import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/controller/categories/categories_controller.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/di/config_inject.dart';
import 'package:password_manager/ui/main/main_ui/password_details_page.dart';
import 'package:password_manager/ui/shared/common_ui.dart';
import 'package:password_manager/ui/shared/list_item.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:search_page/search_page.dart';
import 'package:password_manager/ext/ext.dart';

class CategoriesDetails extends StatelessWidget {
  final Encrypter encrypter = Get.find(tag: "ENCRYPT");
  final String uuid;
  final String title;

  CategoriesDetails(this.uuid, this.title);

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
            color: Get.iconColor,
          ),
        ),
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          InkWell(
            onTap: () {
              showSearchPage(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.search,
                color: Get.iconColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDeleteDialog();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 10),
              child: Icon(
                FontAwesomeIcons.trashAlt,
                color: Get.iconColor,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: GetX<CategoriesController>(
          init: getIt<CategoriesController>(),
          initState: (_) {
            CategoriesController.to.getAllData(uuid);
          },
          builder: (CategoriesController ctl) {
            var data = ctl.passwordModelStatus.value;
            switch (data.state) {
              case DataState.INIT:
              case DataState.LOADING:
                return CommonUI.showLoading();
              case DataState.NO_INTERNET:
                return CommonUI.showOffline();
              case DataState.LOADED:
                if (data.data.isEmpty) {
                  return CommonUI.showFailed("No saved password found");
                }

                return ListView.builder(
                  itemCount: data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var model = data.data[index];
                    return ListItemUI.passList(model, encrypter);
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

  void deletePassword() async {
    var res = await AppController.to.deleteCategory(uuid);
    if (res) {
      Get.back(closeOverlays: true);
      SnackBarHelper.showSuccess("Category deleted successfully");
    }
  }

  void showDeleteDialog() {
    Get.defaultDialog(
      title: "Confirmation Alert",
      middleText:
          "Are you sure to delete this category and all the password under this category?",
      middleTextStyle: TextStyle(
        fontSize: 15,
      ),
      confirmTextColor: Colors.white,
      onConfirm: () {
        deletePassword();
      },
      onCancel: () {
        // Get.back();
      },
    );
  }

  void showSearchPage(BuildContext context) {
    var data = CategoriesController.to.passwordModelStatus.value.data;

    //cehck data
    if (data.isEmpty == true) {
      SnackBarHelper.showError("Empty password list");
      return;
    }

    showSearch(
      context: context,
      delegate: SearchPage<PasswordModel>(
        items: data,
        searchLabel: 'Search password',
        suggestion: Center(
          child: Text('Filter password by name'),
        ),
        failure: Center(
          child: Text('No password found :('),
        ),
        filter: (model) => [
          model.companyName,
        ],
        builder: (model) => ListTile(
          onTap: () {
            var modelDe = model.copyWith(
                userName: model.userName.decrypt(encrypter),
                password: model.password.decrypt(encrypter));
            Get.to(PasswordDetailsUI(modelDe));
          },
          title: Text(
            model.companyName,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "Last updated: ${model.accessedOn.readableString()}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
