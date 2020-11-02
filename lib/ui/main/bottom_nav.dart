import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/main/categories/categories_ui.dart';
import 'package:password_manager/ui/main/main_ui/main_ui.dart';

class BottomNavUI extends StatefulWidget {
  @override
  _BottomNavUIState createState() => _BottomNavUIState();
}

class _BottomNavUIState extends State<BottomNavUI> {
  int _selectedIndex = 0;

  List<Widget> pages;

  MainUI _mainUI;
  CategoriesUI _categoriesUI;

  @override
  void initState() {
    _mainUI = MainUI();
    _categoriesUI = CategoriesUI();
    pages = [_mainUI, _categoriesUI, _mainUI, _categoriesUI];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_selectedIndex != 0) {
            setState(() {
              _selectedIndex = 0;
            });
            return false;
          }
          return true;
        },
        child: pages[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.sync,
        ),
        onPressed: () {
          Get.bottomSheet(showGenerateUI());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTabItem(
                icon: FontAwesomeIcons.home,
                text: "Home",
                index: 0,
                onPressed: (int value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
              ),
              _buildTabItem(
                icon: FontAwesomeIcons.stickyNote,
                text: "Categories",
                index: 1,
                onPressed: (int value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
              ),
              SizedBox(
                width: 50,
              ),
              _buildTabItem(
                icon: FontAwesomeIcons.creditCard,
                text: "Card",
                index: 2,
                onPressed: (int value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
              ),
              _buildTabItem(
                icon: Icons.settings,
                text: "Settings",
                index: 3,
                onPressed: (int value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
              ),
            ],
          ),
        ),
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
      ),
    );
  }

  Widget _buildTabItem({
    IconData icon,
    String text,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? Colors.orange : Colors.white;
    return Expanded(
      child: SizedBox(
        height: 70,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: color, size: 25),
                SizedBox(
                  height: 5,
                ),
                Text(
                  text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showGenerateUI() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      width: Get.width,
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Generate Secure Password",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.blue.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "pass" * 4,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.sync,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
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
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.fence,
                            color: Colors.blue,
                          ),
                          Text(
                            "ADVANCE OPTIONS",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.save_rounded,
                            color: Colors.blue,
                          ),
                          Text(
                            "SAVE",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
