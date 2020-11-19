import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/main/cards/cards_page.dart';
import 'package:password_manager/ui/main/categories/categories_ui.dart';
import 'package:password_manager/ui/main/main_ui/main_ui.dart';
import 'package:password_manager/ui/main/settings/settings_page.dart';
import 'package:password_manager/ui/shared/modal_sheet.dart';

class BottomNavUI extends StatefulWidget {
  @override
  _BottomNavUIState createState() => _BottomNavUIState();
}

class _BottomNavUIState extends State<BottomNavUI> {
  int _selectedIndex = 0;

  List<Widget> pages;

  HomePageUI _homePageUI;
  CategoriesUI _categoriesUI;
  CardPageUI _cardPageUI;
  SettingsPageUi _settingsPageUi;

  void initFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    initFirebase();
    _homePageUI = HomePageUI();
    _categoriesUI = CategoriesUI();
    _cardPageUI = CardPageUI();
    _settingsPageUi = SettingsPageUi();

    pages = [_homePageUI, _categoriesUI, _cardPageUI, _settingsPageUi];

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
          Get.bottomSheet(SheetUIHelper.showGenerateUI());
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
}
