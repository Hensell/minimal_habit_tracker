import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static Future<dynamic> deleteDialog({
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
}
