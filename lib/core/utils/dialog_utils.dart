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
            title: const Text('Eliminar habito'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      '¿Esta seguro que desea eliminar este habito? esta accion no se puede deshacer.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Eliminar'),
                onPressed: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
