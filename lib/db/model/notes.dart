import 'dart:convert';

class NotesModel {
  String notes;
  DateTime updatedDate;

  NotesModel(
    this.notes,
    this.updatedDate,
  );

  NotesModel copyWith({
    String notes,
    DateTime updatedDate,
  }) {
    return NotesModel(
      notes ?? this.notes,
      updatedDate ?? this.updatedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notes': notes,
      'updatedDate': updatedDate?.millisecondsSinceEpoch,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NotesModel(
      map['notes'],
      DateTime.fromMillisecondsSinceEpoch(map['updatedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesModel.fromJson(String source) =>
      NotesModel.fromMap(json.decode(source));

  @override
  String toString() => 'NotesModel(notes: $notes, updatedDate: $updatedDate)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NotesModel && o.notes == notes && o.updatedDate == updatedDate;
  }

  @override
  int get hashCode => notes.hashCode ^ updatedDate.hashCode;
}
