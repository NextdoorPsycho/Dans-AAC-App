import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

genericError(BuildContext context, String topText, String bottomText,
    {int time = 3}) {
  error("Generic Error - $topText");
  return toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    title: Text(topText),
    description: Text(bottomText),
    alignment: Alignment.topCenter,
    autoCloseDuration: Duration(seconds: time),
    animationBuilder: (
      context,
      animation,
      alignment,
      child,
    ) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: const Icon(
      Icons.error_outline_sharp,
    ),
    borderRadius: BorderRadius.circular(4.0),
    boxShadow: highModeShadow,
    showProgressBar: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}
