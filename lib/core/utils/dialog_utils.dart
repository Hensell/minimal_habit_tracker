import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

  static Future<dynamic> genericMesseage({
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Timer(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
            title: const Text('Alerta'),
            content: const Text('La descripcion y/o el nombre estan vacios.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static Future<dynamic> addDialog({
    required BuildContext context,
    required IconData defaultIcon,
    required TextEditingController nameController,
    required TextEditingController descriptionController,
    required VoidCallback onAdd,
  }) {
    final ValueNotifier<IconData> selectedIcon = ValueNotifier(defaultIcon);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      filled: true, label: Text('Nombre')),
                ),
                const Gap(20),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      filled: true, label: Text('Descripción')),
                ),
                const Gap(20),
                ValueListenableBuilder<IconData>(
                    valueListenable: selectedIcon,
                    builder: (context, value, _) {
                      return DropdownButton<IconData>(
                        isExpanded: true,
                        value: value,
                        items: const [
                          DropdownMenuItem(
                            value: Icons.home,
                            child: Icon(Icons.home),
                          ),
                          DropdownMenuItem(
                            value: Icons.favorite,
                            child: Icon(Icons.favorite),
                          ),
                          DropdownMenuItem(
                            value: Icons.star,
                            child: Icon(Icons.star),
                          ),
                          DropdownMenuItem(
                            value: Icons.shopping_cart,
                            child: Icon(Icons.shopping_cart),
                          )
                        ],
                        onChanged: (IconData? newValue) {
                          selectedIcon.value = newValue!;
                        },
                      );
                    }),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Guardar'),
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    genericMesseage(context: context);
                    return;
                  }
                  onAdd();
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
