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
    this.uuid = "",
    required this.cardNumber,
    required this.name,
    required this.expDate,
    required this.cvc,
    required this.createdDate,
    required this.updatedDate,
  }) {
    if (this.uuid.isEmpty) {
      this.uuid = Uuid().v4();
    }
  }

  CardsModel copyWith({
    String? uuid,
    String? cardNumber,
    String? name,
    String? expDate,
    String? cvc,
    DateTime? createdDate,
    DateTime? updatedDate,
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
      'createdDate': createdDate.millisecondsSinceEpoch,
      'updatedDate': updatedDate.millisecondsSinceEpoch,
    };
  }

  factory CardsModel.fromMap(Map<String, dynamic>? map) {
    return CardsModel(
      uuid: map?['uuid'] ?? "",
      cardNumber: map?['cardNumber'] ?? "",
      name: map?['name'] ?? "",
      expDate: map?['expDate'] ?? "",
      cvc: map?['cvc'] ?? "",
      createdDate: map?["createdDate"] != null
          ? DateTime.fromMillisecondsSinceEpoch(map?['createdDate'])
          : DateTime.now(),
      updatedDate: map?["updatedDate"] != null
          ? DateTime.fromMillisecondsSinceEpoch(map?['updatedDate'])
          : DateTime.now(),
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardsModel &&
        other.uuid == uuid &&
        other.cardNumber == cardNumber &&
        other.name == name &&
        other.expDate == expDate &&
        other.cvc == cvc &&
        other.createdDate == createdDate &&
        other.updatedDate == updatedDate;
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
