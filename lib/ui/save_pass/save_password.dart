import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/db/model/categories_model.dart';
import 'package:password_manager/ext/ext.dart';
import 'package:password_manager/ui/main/categories/create_categories.dart';
import 'package:password_manager/ui/save_pass/save_ui_helper.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

class SavePasswordUI extends StatefulWidget {
  @override
  _SavePasswordState createState() => _SavePasswordState();
}

class _SavePasswordState extends State<SavePasswordUI> {
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var titleController = TextEditingController();

  final AppController controller = Get.find(tag: "APP");

  int _value = 1;

  CategoriesModel? categoriesModel;

  @override
  void initState() {
    controller.getAllData();
    passwordController.text = controller.genPassword.value.pass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Add New Password",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.close,
            color: Colors.blue,
            size: 28,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            buildAddTitle(),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 20, top: 5, bottom: 5),
              alignment: Alignment.topRight,
              child: Text(
                "+ Add New Category",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).materialClick(() {
              CreateCategories.showDialog(controller);
            }),
            SizedBox(
              height: 10,
            ),
            buildCategoryDropdown(),
            SizedBox(
              height: 50,
            ),
            buildInputContainer(),
            // analysis report
            SizedBox(
              height: 50,
            ),
            SaveUIHelper.saveButton(() {
              //handle button click
              if (categoriesModel != null) {
                controller.savePassword(categoriesModel!, titleController.text,
                    userNameController.text, passwordController.text);
              } else {
                SnackBarHelper.showError("Select category");
              }
            }),
          ],
        ),
      ),
    );
  }

  Container buildCategoryDropdown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Text(
            "Category: ",
            style: Get.textTheme.headline6,
          ),
          SizedBox(
            width: 20,
          ),
          GetX<AppController>(
            init: controller,
            builder: (_) {
              var value = controller.categoryStatus.value;
              Fimber.i("Categories List ${value.data.length}");
              if (value.data.isEmpty) {
                return Container();
              }

              categoriesModel = value.data[0];

              return DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _value,
                  items: value.data.map((e) {
                    var index = value.data.indexOf(e);
                    Fimber.i("Drop down index $index");
                    return DropdownMenuItem(
                      child: Text(e.name, style: Get.textTheme.bodyText1),
                      value: index + 1,
                    );
                  }).toList(),
                  onChanged: (pos) {
                    setState(() {
                      _value = pos ?? 1;
                      Fimber.i("Drop down value changed $_value");
                      categoriesModel = value.data[_value - 1];
                    });
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Container buildAddTitle() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Text(
            "Title: ",
            style: Get.textTheme.headline6,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: titleController,
              style: Get.textTheme.bodyText1,
              decoration: InputDecoration(hintText: "write a title"),
            ),
          )
        ],
      ),
    );
  }

  Container buildInputContainer() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.black.withOpacity(0.1),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          SaveUIHelper.getInputLebel("Username"),
          SizedBox(
            height: 15,
          ),
          SaveUIHelper.userInputBox(
            userNameController,
            "username",
          ),
          SizedBox(
            height: 15,
          ),
          SaveUIHelper.getInputLebel("Password"),
          SizedBox(
            height: 15,
          ),
          SaveUIHelper.userInputBox(
            passwordController,
            "password",
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    titleController.dispose();
    super.dispose();
  }
}
