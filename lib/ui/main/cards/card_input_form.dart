import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/card/card_controller.dart';

class CardInputPage extends StatefulWidget {
  const CardInputPage({Key key}) : super(key: key);

  @override
  _CardInputPageState createState() => _CardInputPageState();
}

class _CardInputPageState extends State<CardInputPage> {
  final CardController controller = Get.find();
  CreditCardModel _model;

  @override
  void initState() {
    _model = CreditCardModel("", "", "", "", false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Add new cards",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          CreditCardWidget(
            cardNumber: _model.cardNumber,
            expiryDate: _model.expiryDate,
            cardHolderName: _model.cardHolderName,
            cvvCode: _model.cvvCode,
            showBackView:
                _model.isCvvFocused, //true when you want to show cvv(back) view
          ),
          Container(
            child: CreditCardForm(
              themeColor: Colors.red,
              onCreditCardModelChange: (CreditCardModel data) {
                setState(() {
                  _model = data;
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
                  side: BorderSide(color: Colors.blue),
                ),
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.all(10.0),
                  child: Text("SAVE CARD"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void saveCard() async {
    var res = await controller.addCard(_model);
    if (res) {
      //update list
      Get.back(closeOverlays: true);
    }
  }
}
