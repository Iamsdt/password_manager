import 'package:flutter/material.dart';
import 'package:password_manager/db/model/cards_model.dart';
import 'package:password_manager/ui/shared/card.dart';

class MyCardWidget extends StatefulWidget {
  final CardsModel model;

  MyCardWidget(
    this.model, {
    Key? key,
  }) : super(key: key);

  @override
  _MyCardWidgetState createState() => _MyCardWidgetState();
}

class _MyCardWidgetState extends State<MyCardWidget> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          status = !status;
        });
      },
      child: CreditCardWidget(
        cardNumber: widget.model.cardNumber,
        expiryDate: widget.model.expDate,
        cardHolderName: widget.model.name,
        cvvCode: widget.model.cvc,
        showBackView: status,
      ),
    );
  }
}
