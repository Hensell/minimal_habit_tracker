import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static Future<dynamic> deleteHabitDialog({
    required BuildContext context,
    required VoidCallback onDelete,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.deleteHabit),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.confirmDeletion),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.deleteHabit),
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.dontDelete),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static Future<dynamic> deleteCommentDialog({
    required BuildContext context,
    required VoidCallback onDelete,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.deleteComment),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.confirmDeleteComment),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.deleteComment),
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.dontDelete),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        });
  }

  static Future<dynamic> addCommentDialog(
      {required BuildContext context,
      required VoidCallback onAdd,
      required TextEditingController addCommentController}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.addComment),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.confirmComment),
                  TextFormField(
                    controller: addCommentController,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.addComment),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.addComment),
                onPressed: () {
                  onAdd();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static Future<dynamic> edditCommentDialog(
      {required BuildContext context,
      required VoidCallback onAdd,
      required TextEditingController addCommentController}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.editComment),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.confirmEditDialog),
                  TextFormField(
                    controller: addCommentController,
                    decoration:
                        InputDecoration(hintText: addCommentController.text),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.editComment),
                onPressed: () {
                  onAdd();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
