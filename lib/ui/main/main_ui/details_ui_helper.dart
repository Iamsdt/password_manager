import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:password_manager/controller/home/home_controller.dart';
import 'package:password_manager/db/model/notes.dart';
import 'package:password_manager/ui/main/main_ui/helper/create_notes.dart';

class PasswordDetailsUIHelper {
  static Widget showNotesList(List<NotesModel> notes) {
    if (notes.isEmpty) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) {
        var note = notes[index];
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.2,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            width: Get.width,
            child: Text(
              "Note ${index + 1}:\n" + note.notes,
              style: Get.textTheme.bodyText1,
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: Colors.blue,
              icon: Icons.edit,
              onTap: () {
                CreateNotes.showDialog(
                  note.passwordUUID,
                  initValue: note.notes,
                  noteUUID: note.uuid,
                  edit: true,
                );
              },
            ),
          ],
          secondaryActions: [
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                HomeController.to.deleteNote(note.uuid);
              },
            ),
          ],
        );
      },
    );
  }

  static Column analysisItem(String status, String title) {
    return Column(
      children: [
        Text(
          status,
          style: Get.textTheme.headline4,
        ),
        Text(
          title,
          style: Get.textTheme.bodyText1,
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
        Text(title, style: Get.textTheme.bodyText1),
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
