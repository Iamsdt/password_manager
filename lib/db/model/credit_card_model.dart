import 'dart:convert';

class MyCreditCardModel {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  MyCreditCardModel({
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    this.isCvvFocused,
  });

  MyCreditCardModel copyWith({
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
    bool isCvvFocused,
  }) {
    return MyCreditCardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cvvCode: cvvCode ?? this.cvvCode,
      isCvvFocused: isCvvFocused ?? this.isCvvFocused,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cardHolderName': cardHolderName,
      'cvvCode': cvvCode,
      'isCvvFocused': isCvvFocused,
    };
  }

  factory MyCreditCardModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MyCreditCardModel(
      cardNumber: map['cardNumber'],
      expiryDate: map['expiryDate'],
      cardHolderName: map['cardHolderName'],
      cvvCode: map['cvvCode'],
      isCvvFocused: map['isCvvFocused'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCreditCardModel.fromJson(String source) =>
      MyCreditCardModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyCreditCardModel(cardNumber: $cardNumber, expiryDate: $expiryDate, cardHolderName: $cardHolderName, cvvCode: $cvvCode, isCvvFocused: $isCvvFocused)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MyCreditCardModel &&
        o.cardNumber == cardNumber &&
        o.expiryDate == expiryDate &&
        o.cardHolderName == cardHolderName &&
        o.cvvCode == cvvCode &&
        o.isCvvFocused == isCvvFocused;
  }

  @override
  int get hashCode {
    return cardNumber.hashCode ^
        expiryDate.hashCode ^
        cardHolderName.hashCode ^
        cvvCode.hashCode ^
        isCvvFocused.hashCode;
  }
}
