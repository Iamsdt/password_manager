import 'dart:convert';

import 'package:uuid/uuid.dart';

class CardsModel {
  String uuid;
  String cardNumber;
  String name;
  String expDate;
  String cvc;

  DateTime createdDate;
  DateTime updatedDate;

  CardsModel({
    this.uuid,
    this.cardNumber,
    this.name,
    this.expDate,
    this.cvc,
    this.createdDate,
    this.updatedDate,
  }) {
    //if uuid is null then create one
    if (this.uuid == null) {
      this.uuid = Uuid().v4();
    }
  }

  CardsModel copyWith({
    String uuid,
    String cardNumber,
    String name,
    String expDate,
    String cvc,
    DateTime createdDate,
    DateTime updatedDate,
  }) {
    return CardsModel(
      uuid: uuid ?? this.uuid,
      cardNumber: cardNumber ?? this.cardNumber,
      name: name ?? this.name,
      expDate: expDate ?? this.expDate,
      cvc: cvc ?? this.cvc,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'cardNumber': cardNumber,
      'name': name,
      'expDate': expDate,
      'cvc': cvc,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'updatedDate': updatedDate?.millisecondsSinceEpoch,
    };
  }

  factory CardsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CardsModel(
      uuid: map['uuid'],
      cardNumber: map['cardNumber'],
      name: map['name'],
      expDate: map['expDate'],
      cvc: map['cvc'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      updatedDate: DateTime.fromMillisecondsSinceEpoch(map['updatedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardsModel.fromJson(String source) =>
      CardsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardsModel(uuid: $uuid, cardNumber: $cardNumber, name: $name, expDate: $expDate, cvc: $cvc, createdDate: $createdDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CardsModel &&
        o.uuid == uuid &&
        o.cardNumber == cardNumber &&
        o.name == name &&
        o.expDate == expDate &&
        o.cvc == cvc &&
        o.createdDate == createdDate &&
        o.updatedDate == updatedDate;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        cardNumber.hashCode ^
        name.hashCode ^
        expDate.hashCode ^
        cvc.hashCode ^
        createdDate.hashCode ^
        updatedDate.hashCode;
  }
}
