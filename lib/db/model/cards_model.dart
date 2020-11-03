import 'dart:convert';

class CardsModel {
  String cardNumber;
  String name;
  String expDate;
  String cvc;

  DateTime createdDate;

  CardsModel(
    this.cardNumber,
    this.name,
    this.expDate,
    this.cvc,
    this.createdDate,
  );

  CardsModel copyWith({
    String cardNumber,
    String name,
    String expDate,
    String cvc,
    DateTime createdDate,
  }) {
    return CardsModel(
      cardNumber ?? this.cardNumber,
      name ?? this.name,
      expDate ?? this.expDate,
      cvc ?? this.cvc,
      createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'name': name,
      'expDate': expDate,
      'cvc': cvc,
      'createdDate': createdDate?.millisecondsSinceEpoch,
    };
  }

  factory CardsModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CardsModel(
      map['cardNumber'],
      map['name'],
      map['expDate'],
      map['cvc'],
      DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardsModel.fromJson(String source) =>
      CardsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardsModel(cardNumber: $cardNumber, name: $name, expDate: $expDate, cvc: $cvc, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CardsModel &&
        o.cardNumber == cardNumber &&
        o.name == name &&
        o.expDate == expDate &&
        o.cvc == cvc &&
        o.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return cardNumber.hashCode ^
        name.hashCode ^
        expDate.hashCode ^
        cvc.hashCode ^
        createdDate.hashCode;
  }
}
