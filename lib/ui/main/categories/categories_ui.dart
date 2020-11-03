import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/main/categories/categories_item_details.dart';

class CategoriesUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 10),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 32,
              ),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
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
                    style: TextStyle(fontSize: 20, color: Colors.black38),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((ctx, pos) {
              return Container(
                margin: EdgeInsets.only(top: 5, right: 5),
                child: ListTile(
                  onTap: () {
                    //handle click
                    Get.to(CategoriesDetails());
                  },
                  leading: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white12,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.share,
                    ),
                  ),
                  title: Text("Social Network"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              );
            }, childCount: 10),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
