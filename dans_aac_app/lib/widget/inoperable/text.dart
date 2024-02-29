import 'package:flutter/material.dart';

Widget basicTitle(String text, BuildContext context) {
  return Text(
    text,
    style: myTextStyle(context, title: true),
  );
}

Widget basicSubtext(String text, BuildContext context) {
  return Text(
    text,
    style: myTextStyle(context),
  );
}

TextStyle myTextStyle(BuildContext context,
    {bool title = false,
    bool italic = false,
    bool useSurfaceColor = true,
    FontWeight fontWeight = FontWeight.w400}) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return TextStyle(
    color: useSurfaceColor ? colorScheme.onSurface : colorScheme.surface,
    fontStyle: italic ? FontStyle.italic : FontStyle.normal,
    fontSize: title ? 24 : 16,
    fontWeight: fontWeight,
  );
}
