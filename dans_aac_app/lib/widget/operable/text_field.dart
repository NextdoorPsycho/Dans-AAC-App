import 'package:flutter/material.dart';

Widget textField(
    String label, TextEditingController controller, BuildContext context) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: colorScheme.onSurface),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
      ),
    ),
  );
}
