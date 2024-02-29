import 'package:dans_aac_app/model/app/app_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget themeSwitchTile(BuildContext context) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: ListTile(
      title: Text(
        'Toggle Theme',
        style: TextStyle(color: colorScheme.onSurface),
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (bool value) {
          Provider.of<AppDataModel>(context, listen: false).toggleTheme();
        },
        activeColor: colorScheme.primary,
      ),
    ),
  );
}
