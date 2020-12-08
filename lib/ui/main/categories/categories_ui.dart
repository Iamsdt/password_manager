import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/db/model/categories_model.dart';
import 'package:password_manager/ui/main/categories/categories_item_details.dart';
import 'package:password_manager/ui/main/categories/create_categories.dart';
import 'package:password_manager/ui/shared/common_ui.dart';

class CategoriesUI extends StatelessWidget {
  final AppController controller = Get.find(tag: "APP");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          "Categories",
          style: TextStyle(
            color: context.theme.textTheme.bodyText1.color,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              CreateCategories.showDialog(controller);
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
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
                height: 20,
              ),
              GetX<AppController>(
                init: controller,
                initState: (_) {
                  controller.getAllData();
                },
                builder: (_) {
                  var data = controller.categoryStatus.value;
                  switch (data.state) {
                    case DataState.INIT:
                    case DataState.LOADING:
                      return CommonUI.showLoading();
                    case DataState.NO_INTERNET:
                      return CommonUI.showOffline();
                    case DataState.LOADED:
                      return showLoadedData(data.data);
                    case DataState.FAILED:
                      return CommonUI.showFailed(
                          "Something went wrong! Please try again");
                    default:
                      return Container();
                  }
                },
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showLoadedData(List<CategoriesModel> data) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, pos) {
          var model = data[pos];
          return Container(
            margin: EdgeInsets.only(top: 5, right: 15, left: 20),
            child: ListTile(
              onTap: () {
                //handle click
                // Get.to(CategoriesDetails(model.uuid));
              },
              // leading: Container(
              //   padding: EdgeInsets.all(10.0),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.white12,
              //     ),
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(50),
              //     ),
              //     color: Colors.black.withOpacity(0.1),
              //   ),
              //   child: Icon(
              //     Icons.share,
              //   ),
              // ),
              title: Text(model.name ?? ""),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
