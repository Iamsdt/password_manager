import 'package:credit_card/credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:password_manager/ui/main/cards/card_input_form.dart';

class CardPageUI extends StatelessWidget {
  const CardPageUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "My Cards",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(CardInputPage());
            },
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, pos) {
                bool status = false;
                return InkWell(
                  onTap: () {
                    //todo click
                    status = !status;
                  },
                  child: CreditCardWidget(
                    cardNumber: "4242424242424242",
                    expiryDate: "10/12",
                    cardHolderName: "Test Data",
                    cvvCode: "121",
                    showBackView: status,
                  ),
                );
              },
              childCount: 10,
            ),
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
