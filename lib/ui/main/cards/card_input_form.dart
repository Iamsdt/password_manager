import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/card/card_controller.dart';
import 'package:password_manager/db/model/cards_model.dart';
import 'package:password_manager/db/model/credit_card_model.dart';
import 'package:password_manager/ui/main/cards/my_card_form.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';

class CardInputPage extends StatefulWidget {
  final String title;
  final bool update;
  final CardsModel cardsModel;
  const CardInputPage(this.title, this.update, this.cardsModel, {Key key})
      : super(key: key);

  @override
  _CardInputPageState createState() => _CardInputPageState();
}

class _CardInputPageState extends State<CardInputPage> {
  final CardController controller = Get.find();
  MyCreditCardModel _model;

  @override
  void initState() {
    super.initState();
    if (widget.cardsModel != null) {
      _model = MyCreditCardModel(
        cardHolderName: widget.cardsModel.name,
        cardNumber: widget.cardsModel.cardNumber,
        cvvCode: widget.cardsModel.cvc,
        expiryDate: widget.cardsModel.expDate,
        isCvvFocused: false,
      );
    } else {
      _model = MyCreditCardModel(
        cardHolderName: "",
        cardNumber: "",
        cvvCode: "",
        expiryDate: "",
        isCvvFocused: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: TextStyle(
            color: context.theme.textTheme.bodyText1.color,
          ),
        ),
        iconTheme: IconThemeData(
          color: Get.iconColor, //change your color here
        ),
        actions: [
          widget.update
              ? InkWell(
                  onTap: () {
                    // showDeleteDialog();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25, left: 10),
                    child: Icon(
                      FontAwesomeIcons.trashAlt,
                      color: Get.iconColor,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _model = _model.copyWith(
                  isCvvFocused: !_model.isCvvFocused,
                );
              });
            },
            child: CreditCardWidget(
              cardNumber: _model.cardNumber,
              expiryDate: _model.expiryDate,
              cardHolderName: _model.cardHolderName,
              cvvCode: _model.cvvCode,
              showBackView: _model
                  .isCvvFocused, //true when you want to show cvv(back) view
            ),
          ),
          Container(
            child: MyCreditCardForm(
              cardHolderName: _model.cardHolderName,
              cardNumber: _model.cardNumber,
              cvvCode: _model.cvvCode,
              expiryDate: _model.expiryDate,
              themeColor: Colors.red,
              textColor: Get.isDarkMode ? Colors.white : Colors.black,
              onCreditCardModelChange: (CreditCardModel data) {
                setState(() {
                  _model = _model = MyCreditCardModel(
                    cardHolderName: data.cardHolderName,
                    cardNumber: data.cardNumber,
                    cvvCode: data.cvvCode,
                    expiryDate: data.expiryDate,
                    isCvvFocused: data.isCvvFocused,
                  );
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  widget.update ? updateCard() : saveCard();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.all(10.0),
                  child: Text(widget.update ? "UPDATE CARD" : "SAVE CARD"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  void showDeleteDialog() {
    Get.defaultDialog(
      title: "Confirmation Alert",
      middleText: "Are you sure to delete the credit card?",
      middleTextStyle: TextStyle(
        fontSize: 15,
      ),
      confirmTextColor: Colors.white,
      onConfirm: () {
        deleteCard();
      },
      onCancel: () {
        // Get.back();
      },
    );
  }

  void deleteCard() async {
    var res = await controller.addCard(_model);
    if (res) {
      //update list
      Get.back();
      SnackBarHelper.showSuccess("Card deleted successfully");
    }
  }

  void saveCard() async {
    var res = await controller.addCard(_model);
    if (res) {
      //update list
      Get.back();
      SnackBarHelper.showSuccess("Card added successfully");
    }
  }

  void updateCard() async {
    var res = await controller.addCard(_model);
    if (res) {
      //update list
      // Get.back();
      SnackBarHelper.showSuccess("Card updated successfully");
    }
  }
}
