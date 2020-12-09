import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/controller/app_controller.dart';
import 'package:password_manager/controller/home/home_controller.dart';
import 'package:password_manager/db/model/categories_model.dart';
import 'package:password_manager/db/model/notes.dart';
import 'package:password_manager/db/model/password_model.dart';
import 'package:password_manager/ui/main/categories/create_categories.dart';
import 'package:password_manager/ui/main/main_ui/details_ui_helper.dart';
import 'package:password_manager/ui/main/main_ui/helper/create_notes.dart';
import 'package:password_manager/ui/shared/auth_helper_ui.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/utils/utils.dart';
import 'package:password_manager/ext/ext.dart';

class PasswordDetailsUI extends StatefulWidget {
  final PasswordModel model;

  PasswordDetailsUI(this.model);

  @override
  _PasswordDetailsUIState createState() => _PasswordDetailsUIState();
}

class _PasswordDetailsUIState extends State<PasswordDetailsUI> {
  AppController controller = AppController.to;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool edidtable = false;

  CategoriesModel categoriesModel;
  int catValue = 1;

  int strength = 0;

  void findCatValue() {
    var catID = widget.model.categories;

    var list = controller.categoryStatus.value.data;
    var index = list.indexWhere((e) => e.uuid == catID);

    //otherwise not found
    if (index >= 0) {
      setState(() {
        categoriesModel = list[index];
        catValue = index + 1; //dropdown start from 1
      });
    }
  }

  @override
  void initState() {
    super.initState();

    //gets all notes
    HomeController.to.getNotes(widget.model.uuid);

    titleController.text = widget.model.companyName;
    usernameController.text = widget.model.userName;
    passwordController.text = widget.model.password;

    findCatValue();

    strength = widget.model.strength;
  }

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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.share,
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              topTitle(),
              SizedBox(
                height: 20,
              ),
              edidtable
                  ? Container(
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
                    })
                  : Container(),
              SizedBox(
                height: 10,
              ),
              buildCategoryDropdown(),
              SizedBox(
                height: 50,
              ),
              Container(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    showPassbox(Icons.person, usernameController, false,
                        (value) {
                      // nothing to do
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    showPassbox(Icons.lock, passwordController, true, (value) {
                      var res = Utils.analysisPassword(value);
                      setState(() {
                        strength = res;
                      });
                    }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PasswordDetailsUIHelper.strengthItem(
                        strength, "Password Strength"),
                    PasswordDetailsUIHelper.analysisItem(
                      "${Utils.getPassUpdatedDay(widget.model.updated)} d",
                      "Last update days ago",
                    ),
                  ],
                ),
              ),
              showSavedButton(edidtable),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "+ Add Notes",
                      ).materialClick(() {
                        //click add notes
                        CreateNotes.showDialog(controller, widget.model.uuid);
                      }),
                    ),
                    GetX<HomeController>(
                      init: HomeController.to,
                      builder: (HomeController ctl) {
                        var state = ctl.notesModelStatus.value;
                        if (state.state == DataState.LOADED) {
                          return PasswordDetailsUIHelper.showNotesList(
                              state.data);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //show category drop down
  Container buildCategoryDropdown() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Text(
            "Category: ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GetX<AppController>(
            init: controller,
            builder: (_) {
              var value = controller.categoryStatus.value;
              Fimber.i("Categories List ${value.data?.length}");
              if (value.data == null || value.data?.isEmpty == true) {
                return Container();
              }

              categoriesModel = value.data[0];

              return DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: catValue,
                  items: value.data.map((e) {
                    var index = value.data.indexOf(e);
                    Fimber.i("Drop down index $index");
                    return DropdownMenuItem(
                      child: Text(e.name),
                      value: index + 1,
                    );
                  }).toList(),
                  onChanged: (pos) {
                    if (edidtable) {
                      setState(() {
                        catValue = pos;
                        Fimber.i("Drop down value changed $catValue");
                        categoriesModel = value.data[pos - 1];
                      });
                    }
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Container topTitle() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20.0),
      child: Row(
        children: [
          // Image.asset(
          //   "assets/images/google.png",
          //   width: 24,
          //   height: 24,
          // ),
          // SizedBox(
          //   width: 20,
          // ),
          Expanded(
            child: TextFormField(
              enabled: edidtable,
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                edidtable = !edidtable;
              });
            },
            child: Icon(
              Icons.edit_outlined,
            ),
          )
        ],
      ),
    );
  }

  Container showPassbox(
    IconData icon,
    TextEditingController controller,
    bool isShowPassword,
    void onChanged(String value),
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
              ),
              child: ObxValue(
                (data) => TextFormField(
                  controller: controller,
                  readOnly: !edidtable,
                  onChanged: (value) {
                    onChanged(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      icon,
                      color: Colors.blue[500],
                      size: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        data.value = !data.value;
                      },
                      child: Icon(
                        data.value ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: data.value,
                ),
                isShowPassword.obs,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              //hello
              Clipboard.setData(new ClipboardData(text: controller.text));
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.blue,
              ),
              child: Text(
                "COPY",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showSavedButton(bool show) {
    return show
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.5,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF00B9FF),
                  ),
                  color: Color(0xFF00B9FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Get.isDarkMode
                          ? Colors.grey.shade900
                          : Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: MaterialButton(
                  onPressed: () {
                    update();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      "UPDATE",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  void update() async {
    var model = widget.model.copyWith(
      updated: DateTime.now(),
      companyName: titleController.text,
      password: passwordController.text,
      userName: usernameController.text,
      categories: categoriesModel.uuid,
      strength: Utils.analysisPassword(passwordController.text),
    );

    var res = await controller.updateSavePassword(model);
    if (res) {
      setState(() {
        edidtable = false;
      });
    }
  }

  //delete password and back to previous ui
  void deletePassword() async {
    var res = await controller.deletePassword(widget.model);
    if (res) {
      Get.back(closeOverlays: true);
      SnackBarHelper.showSuccess("Password deleted successfully");
    }
  }

  void showDeleteDialog() {
    Get.defaultDialog(
      title: "Confirmation Alert",
      middleText: "Are you sure to delete the password?",
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

  @override
  void dispose() {
    titleController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}
