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
    required this.companyName,
    required this.userName,
    required this.password,
    required this.strength,
    required this.iconPath,
    required this.categories,
    required this.updated,
    required this.accessedOn,
    this.uuid = "",
  }) {
    if (this.uuid.isEmpty) {
      this.uuid = Uuid().v4();
    }
  }

  PasswordModel copyWith({
    String? companyName,
    String? userName,
    String? password,
    int? strength,
    String? iconPath,
    String? categories,
    DateTime? updated,
    DateTime? accessedOn,
    String? uuid,
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
      'categories': categories,
      'updated': updated.millisecondsSinceEpoch,
      'accessedOn': accessedOn.millisecondsSinceEpoch,
      'uuid': uuid,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic>? map) {
    return PasswordModel(
      companyName: map?['companyName'] ?? "",
      userName: map?['userName'] ?? "",
      password: map?['password'] ?? "",
      strength: map?['strength'] ?? "",
      iconPath: map?['iconPath'] ?? "",
      categories: map?['categories'] ?? "",
      updated: map?["updated"] != null
          ? DateTime.fromMillisecondsSinceEpoch(map?['updated'])
          : DateTime.now(),
      accessedOn: map?["updated"] != null
          ? DateTime.fromMillisecondsSinceEpoch(map?['accessedOn'])
          : DateTime.now(),
      uuid: map?['uuid'] ?? "",
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PasswordModel &&
        other.companyName == companyName &&
        other.userName == userName &&
        other.password == password &&
        other.strength == strength &&
        other.iconPath == iconPath &&
        other.categories == categories &&
        other.updated == updated &&
        other.accessedOn == accessedOn &&
        other.uuid == uuid;
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
}
