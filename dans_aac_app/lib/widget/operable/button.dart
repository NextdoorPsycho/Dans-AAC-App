import 'package:flutter/material.dart';

Widget customSwitchTile({
  required String title,
  required bool value,
  required Function(bool) onChanged,
  required BuildContext context,
}) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(0.2), // Faint outline color
          width: 1, // Adjust the width as needed
        ),
        borderRadius: BorderRadius.circular(4.0), // Optional: round corners
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: colorScheme.onSurface),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: colorScheme.primary,
          activeTrackColor: colorScheme.background,
        ),
      ),
    ),
  );
}
