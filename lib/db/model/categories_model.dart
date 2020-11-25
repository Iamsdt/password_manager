import 'dart:convert';

class CategoriesModel {
  String name;
  String icon;

  CategoriesModel({
    this.name,
    this.icon,
  });

  CategoriesModel copyWith({
    String name,
    String icon,
  }) {
    return CategoriesModel(
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoriesModel(
      name: map['name'],
      icon: map['icon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source));

  @override
  String toString() => 'CategoriesModel(name: $name, icon: $icon)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CategoriesModel && o.name == name && o.icon == icon;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode;
}
