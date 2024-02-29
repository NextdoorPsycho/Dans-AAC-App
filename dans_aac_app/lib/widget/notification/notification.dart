import 'package:dans_aac_app/widget/inoperable/text.dart';
import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

genericNotification(BuildContext context, String topText, String bottomText,
    {int time = 3}) {
  info("Generic Notification - $topText");
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return toastification.show(
    context: context,
    backgroundColor: colorScheme.surface,
    type: ToastificationType.success,
    foregroundColor: colorScheme.onSurface,
    style: ToastificationStyle.fillColored,
    title: Text(
      topText,
      style: myTextStyle(context, title: true),
    ),
    description: Text(
      bottomText,
      style: myTextStyle(context),
    ),
    alignment: Alignment.topCenter,
    autoCloseDuration: Duration(seconds: time),
    primaryColor: colorScheme.primary,
    icon: Icon(Icons.keyboard_arrow_right_sharp, color: colorScheme.onSurface),
    borderRadius: BorderRadius.circular(1.0),
    boxShadow: lowModeShadow,
    dragToClose: true,
    closeOnClick: true,
    closeButtonShowType: CloseButtonShowType.always,
    pauseOnHover: true,
    applyBlurEffect: true,
  );
}
