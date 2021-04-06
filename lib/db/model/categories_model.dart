import 'dart:convert';

import 'package:uuid/uuid.dart';

class CategoriesModel {
  String name;
  String icon;
  String uuid;

  CategoriesModel({
    required this.name,
    required this.icon,
    this.uuid = "",
  }) {
    if (this.uuid.isEmpty) {
      this.uuid = Uuid().v4();
    }
  }

  CategoriesModel copyWith({
    String? name,
    String? icon,
    String? uuid,
  }) {
    return CategoriesModel(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'uuid': uuid,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic>? map) {
    return CategoriesModel(
      name: map?['name'] ?? "",
      icon: map?['icon'] ?? "",
      uuid: map?['uuid'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source));

  @override
  String toString() => 'CategoriesModel(name: $name, icon: $icon, uuid: $uuid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoriesModel &&
        other.name == name &&
        other.icon == icon &&
        other.uuid == uuid;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ uuid.hashCode;
}
