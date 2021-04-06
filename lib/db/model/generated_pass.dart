import 'dart:convert';

class GeneratedPassword {
  String pass;
  bool isLowerCase;
  bool isUpperCase;
  bool isNumbers;
  bool isSpecial;

  GeneratedPassword({
    required this.pass,
    this.isLowerCase = false,
    this.isUpperCase = false,
    this.isNumbers = false,
    this.isSpecial = false,
  });

  GeneratedPassword copyWith({
    String? pass,
    bool? isLowerCase,
    bool? isUpperCase,
    bool? isNumbers,
    bool? isSpecial,
  }) {
    return GeneratedPassword(
      pass: pass ?? this.pass,
      isLowerCase: isLowerCase ?? this.isLowerCase,
      isUpperCase: isUpperCase ?? this.isUpperCase,
      isNumbers: isNumbers ?? this.isNumbers,
      isSpecial: isSpecial ?? this.isSpecial,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pass': pass,
      'isLowerCase': isLowerCase,
      'isUpperCase': isUpperCase,
      'isNumbers': isNumbers,
      'isSpecial': isSpecial,
    };
  }

  factory GeneratedPassword.fromMap(Map<String, dynamic> map) {
    return GeneratedPassword(
      pass: map['pass'],
      isLowerCase: map['isLowerCase'],
      isUpperCase: map['isUpperCase'],
      isNumbers: map['isNumbers'],
      isSpecial: map['isSpecial'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneratedPassword.fromJson(String source) =>
      GeneratedPassword.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeneratedPassword(pass: $pass, isLowerCase: $isLowerCase, isUpperCase: $isUpperCase, isNumbers: $isNumbers, isSpecial: $isSpecial)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneratedPassword &&
        other.pass == pass &&
        other.isLowerCase == isLowerCase &&
        other.isUpperCase == isUpperCase &&
        other.isNumbers == isNumbers &&
        other.isSpecial == isSpecial;
  }

  @override
  int get hashCode {
    return pass.hashCode ^
        isLowerCase.hashCode ^
        isUpperCase.hashCode ^
        isNumbers.hashCode ^
        isSpecial.hashCode;
  }
}
