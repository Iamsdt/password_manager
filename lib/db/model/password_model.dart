import 'dart:convert';

import 'package:uuid/uuid.dart';

class PasswordModel {
  String companyName;
  String userName;
  String password;
  int strength;
  String iconPath;
  String categories;
  DateTime updated;
  DateTime accessedOn;
  String uuid;

  PasswordModel({
    this.companyName,
    this.userName,
    this.password,
    this.strength,
    this.iconPath,
    this.categories,
    this.updated,
    this.accessedOn,
    this.uuid,
  }) {
    if (this.uuid == null) {
      this.uuid = Uuid().v4();
    }
  }

  PasswordModel copyWith({
    String companyName,
    String userName,
    String password,
    int strength,
    String iconPath,
    String categories,
    DateTime updated,
    DateTime accessedOn,
    String uuid,
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
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'userName': userName,
      'password': password,
      'strength': strength,
      'iconPath': iconPath,
      'category': categories,
      'updated': updated?.millisecondsSinceEpoch,
      'accessedOn': accessedOn?.millisecondsSinceEpoch,
      'uuid': uuid,
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
      categories: map['category'],
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated']),
      accessedOn: DateTime.fromMillisecondsSinceEpoch(map['accessedOn']),
      uuid: map['uuid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordModel.fromJson(String source) =>
      PasswordModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PasswordModel(companyName: $companyName, userName: $userName, password: $password, strength: $strength, iconPath: $iconPath, categories: $categories, updated: $updated, accessedOn: $accessedOn, uuid: $uuid)';
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
        o.accessedOn == accessedOn &&
        o.uuid == uuid;
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
        accessedOn.hashCode ^
        uuid.hashCode;
  }

  // PasswordModel encrypt(Encrypter en) {
  //   return PasswordModel(
  //     companyName: encryptString(en, this.companyName),
  //     userName: encryptString(en, this.userName),
  //     password: encryptString(en, this.password),
  //     strength: this.strength,
  //     iconPath: this.iconPath,
  //     categories: this.categories,
  //     updated: this.updated,
  //     accessedOn: this.accessedOn,
  //   );
  // }

  // PasswordModel decrypt(Encrypter en) {
  //   this.companyName = decryptString(en, this.companyName);
  //   this.userName = decryptString(en, this.userName);
  //   this.password = decryptString(en, this.password);

  //   return PasswordModel(
  //     companyName: this.companyName,
  //     userName: this.userName,
  //     password: this.password,
  //     strength: this.strength,
  //     iconPath: this.iconPath,
  //     categories: this.categories,
  //     updated: this.updated,
  //     accessedOn: this.accessedOn,
  //   );
  // }
}
