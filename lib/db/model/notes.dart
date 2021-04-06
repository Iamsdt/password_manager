import 'dart:convert';

import 'package:uuid/uuid.dart';

class NotesModel {
  String notes;
  DateTime updatedDate;
  String uuid;
  String passwordUUID;

  NotesModel({
    required this.notes,
    required this.updatedDate,
    this.uuid = "",
    required this.passwordUUID,
  }) {
    if (this.uuid.isEmpty) {
      this.uuid = Uuid().v4();
    }
  }

  NotesModel copyWith({
    String? notes,
    DateTime? updatedDate,
    String? uuid,
    String? passwordUUID,
  }) {
    return NotesModel(
      notes: notes ?? this.notes,
      updatedDate: updatedDate ?? this.updatedDate,
      uuid: uuid ?? this.uuid,
      passwordUUID: passwordUUID ?? this.passwordUUID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notes': notes,
      'updatedDate': updatedDate.millisecondsSinceEpoch,
      'uuid': uuid,
      'passwordUUID': passwordUUID,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic>? map) {
    return NotesModel(
      notes: map?['notes'] ?? "",
      updatedDate: map?['updatedDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map?['updatedDate'])
          : DateTime.now(),
      uuid: map?['uuid'] ?? "",
      passwordUUID: map?['passwordUUID'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesModel.fromJson(String source) =>
      NotesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotesModel(notes: $notes, updatedDate: $updatedDate, uuid: $uuid, passwordUUID: $passwordUUID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotesModel &&
        other.notes == notes &&
        other.updatedDate == updatedDate &&
        other.uuid == uuid &&
        other.passwordUUID == passwordUUID;
  }

  @override
  int get hashCode {
    return notes.hashCode ^
        updatedDate.hashCode ^
        uuid.hashCode ^
        passwordUUID.hashCode;
  }
}
