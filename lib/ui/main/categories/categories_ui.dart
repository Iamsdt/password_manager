import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
            color: context.theme.textTheme.bodyText1?.color,
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
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(left: 20, right: 20),
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
                  return getSliver(CommonUI.showLoading());
                case DataState.LOADED:
                  return showLoadedData(data.data);
                case DataState.FAILED:
                  return getSliver(CommonUI.showFailed(
                      "Something went wrong! Please try again"));
                default:
                  return getSliver(Container());
              }
            },
          ),
        ],
      ),
    );
  }

  //conver to sliver
  Widget getSliver(Widget child) {
    return SliverToBoxAdapter(
      child: child,
    );
  }

  Widget showLoadedData(List<CategoriesModel> data) {
    if (data.isEmpty) {
      return getSliver(
        CommonUI.showFailed(
          "No Category found",
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, pos) {
          var model = data[pos];
          print("Building position: $pos");
          return Container(
            margin: EdgeInsets.only(top: 5, right: 15, left: 20),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: ListTile(
                onTap: () {
                  //handle click
                  Get.to(() => CategoriesDetails(model.uuid, model.name));
                  controller.removeFocus();
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
                title: Text(model.name, style: Get.textTheme.bodyText1),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () {
                    CreateCategories.showDialog(
                      controller,
                      initText: model.name,
                      uuid: model.uuid,
                      edit: true,
                    );
                  },
                ),
              ],
            ),
          );
        },
        childCount: data.length,
      ),
    );
  }
}
