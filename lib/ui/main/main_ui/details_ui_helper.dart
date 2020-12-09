import 'package:flutter/material.dart';
import 'package:password_manager/db/model/notes.dart';

class PasswordDetailsUIHelper {
  static Widget showNotesList(List<NotesModel> notes) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        var note = notes[index];
        return Text(
          "Notes:\n" + note.notes,
        );
      },
    );
  }

  static Column analysisItem(String status, String title) {
    return Column(
      children: [
        Text(
          status,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  static Column strengthItem(int value, String title) {
    return Column(
      children: [
        Text(
          getStrength(value),
          style: TextStyle(
            fontSize: 32,
            color: getStrengthColor(value),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  static String getStrength(int value) {
    if (value >= 80)
      return "STRONG";
    else if (value >= 60)
      return "MEDIUM";
    else if (value >= 40)
      return "FAIR";
    else
      return "POOR";
  }

  static Color getStrengthColor(int value) {
    if (value >= 80)
      return Colors.green;
    else if (value >= 60)
      return Colors.cyan;
    else if (value >= 40)
      return Colors.yellow;
    else
      return Colors.red;
  }
}
