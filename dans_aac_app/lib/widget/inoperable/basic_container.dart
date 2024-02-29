import 'package:flutter/material.dart';

Widget basicContainer(BuildContext context, List<Widget> children) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ...children,
        ],
      ),
    ),
  );
}
