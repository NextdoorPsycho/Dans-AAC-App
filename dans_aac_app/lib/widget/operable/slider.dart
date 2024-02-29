import 'package:flutter/material.dart';

Widget basicSlider(
    double value, Function(double) onChanged, BuildContext context) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return Slider(
    value: value,
    onChanged: onChanged,
    activeColor: colorScheme.primary,
    inactiveColor: colorScheme.onSurface.withOpacity(0.3),
  );
}
