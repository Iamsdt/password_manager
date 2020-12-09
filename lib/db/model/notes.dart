import 'dart:convert';
import 'package:uuid/uuid.dart';

class NotesModel {
  String notes;
  DateTime updatedDate;
  String uuid;
  String passwordUUID;

  NotesModel({
    this.notes,
    this.updatedDate,
    this.uuid,
    this.passwordUUID,
  }) {
    if (this.uuid == null) {
      this.uuid = Uuid().v4();
    }

    if (this.updatedDate == null) {
      this.updatedDate = DateTime.now();
    }
  }

  NotesModel copyWith({
    String notes,
    DateTime updatedDate,
    String uuid,
    String passwordUUID,
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
      'updatedDate': updatedDate?.millisecondsSinceEpoch,
      'uuid': uuid,
      'passwordUUID': passwordUUID,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NotesModel(
      notes: map['notes'],
      updatedDate: DateTime.fromMillisecondsSinceEpoch(map['updatedDate']),
      uuid: map['uuid'],
      passwordUUID: map['passwordUUID'],
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
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NotesModel &&
        o.notes == notes &&
        o.updatedDate == updatedDate &&
        o.uuid == uuid &&
        o.passwordUUID == passwordUUID;
  }

  @override
  int get hashCode {
    return notes.hashCode ^
        updatedDate.hashCode ^
        uuid.hashCode ^
        passwordUUID.hashCode;
  }
}
