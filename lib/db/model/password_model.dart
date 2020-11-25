import 'dart:convert';

import 'package:encrypt/encrypt.dart';

import 'package:password_manager/utils/encrtypt.dart';

class PasswordModel {
  String companyName;
  String userName;
  String password;
  String strength;
  String iconPath;
  String categories;
  DateTime updated;
  DateTime accessedOn;

  PasswordModel({
    this.companyName,
    this.userName,
    this.password,
    this.strength,
    this.iconPath,
    this.categories,
    this.updated,
    this.accessedOn,
  });

  PasswordModel copyWith({
    String companyName,
    String userName,
    String password,
    String strength,
    String iconPath,
    String categories,
    DateTime updated,
    DateTime accessedOn,
  }) {
    return PasswordModel(
      companyName: companyName ?? this.companyName,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      strength: strength ?? this.strength,
      iconPath: iconPath ?? this.iconPath,
      categories: categories ?? this.categories,
      updated: updated ?? this.updated,
      accessedOn: accessedOn ?? this.accessedOn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'userName': userName,
      'password': password,
      'strength': strength,
      'iconPath': iconPath,
      'categories': categories,
      'updated': updated?.millisecondsSinceEpoch,
      'accessedOn': accessedOn?.millisecondsSinceEpoch,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PasswordModel(
      companyName: map['companyName'],
      userName: map['userName'],
      password: map['password'],
      strength: map['strength'],
      iconPath: map['iconPath'],
      categories: map['categories'],
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated']),
      accessedOn: DateTime.fromMillisecondsSinceEpoch(map['accessedOn']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordModel.fromJson(String source) =>
      PasswordModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PasswordModel(companyName: $companyName, userName: $userName, password: $password, strength: $strength, iconPath: $iconPath, categories: $categories, updated: $updated, accessedOn: $accessedOn)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PasswordModel &&
        o.companyName == companyName &&
        o.userName == userName &&
        o.password == password &&
        o.strength == strength &&
        o.iconPath == iconPath &&
        o.categories == categories &&
        o.updated == updated &&
        o.accessedOn == accessedOn;
  }

  @override
  int get hashCode {
    return companyName.hashCode ^
        userName.hashCode ^
        password.hashCode ^
        strength.hashCode ^
        iconPath.hashCode ^
        categories.hashCode ^
        updated.hashCode ^
        accessedOn.hashCode;
  }

  PasswordModel encrypt(Encrypter en) {
    return PasswordModel(
      companyName: encryptString(en, this.companyName),
      userName: encryptString(en, this.userName),
      password: encryptString(en, this.password),
      strength: this.strength,
      iconPath: this.iconPath,
      categories: this.categories,
      updated: this.updated,
      accessedOn: this.accessedOn,
    );
  }

  PasswordModel decrypt(Encrypter en) {
    this.companyName = decryptString(en, this.companyName);
    this.userName = decryptString(en, this.userName);
    this.password = decryptString(en, this.password);

    return PasswordModel(
      companyName: this.companyName,
      userName: this.userName,
      password: this.password,
      strength: this.strength,
      iconPath: this.iconPath,
      categories: this.categories,
      updated: this.updated,
      accessedOn: this.accessedOn,
    );
  }
}
