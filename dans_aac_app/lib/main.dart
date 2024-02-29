import 'package:dans_aac_app/aggregator.dart';
import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:window_manager/window_manager.dart';

import 'model/app/app_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(850, 1100),
    center: true,
    backgroundColor: Colors.transparent,
    title: 'DANS AAC App',
    alwaysOnTop: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    runApp(const MyApp());
    success('[App Started]');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppDataModel(),
      child: Consumer<AppDataModel>(
        builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _lightTheme(),
            darkTheme: _darkTheme(),
            themeMode: model.themeMode == AppThemeMode.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const ToastificationConfigProvider(
              config: ToastificationConfig(
                alignment: Alignment.center,
                itemWidth: 440,
                animationDuration: Duration(milliseconds: 500),
              ),
              child: Aggregator(),
            ),
          );
        },
      ),
    );
  }
}

ThemeData applyTheme(ThemeData t) {
  return t.copyWith(
    textTheme: t.textTheme.apply(fontFamily: 'h'),
    bottomNavigationBarTheme: t.bottomNavigationBarTheme.copyWith(
      backgroundColor: t.cardColor,
    ),
    appBarTheme: t.appBarTheme.copyWith(
      titleTextStyle:
          (t.appBarTheme.titleTextStyle ?? const TextStyle()).copyWith(
        color: t.colorScheme.onPrimary,
        fontSize: 24,
        fontFamily: 'h',
      ),
    ),
    navigationRailTheme: t.navigationRailTheme.copyWith(
      backgroundColor: t.brightness == Brightness.dark
          ? Colors.grey[850]
          : Colors.grey[300], // Corrected potential typo in Colors.grey[3040]
      selectedIconTheme: IconThemeData(color: t.colorScheme.primary),
      unselectedIconTheme: IconThemeData(color: t.hoverColor.withOpacity(0.5)),
    ),
  );
}

ThemeData _darkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF800000), // Maroon as the seed color
      brightness: Brightness.dark,
      primary: const Color(0xFF800000), // Maroon for primary
      secondary: const Color(0xFF008080), // Teal (complementary) for secondary
      surface: const Color(0xFF121212), // Dark surface
      background: const Color(0xFF212121), // Dark background
      error: const Color(0xFFCF6679), // Default dark theme error
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFFFFFFFF),
      onBackground: const Color(0xFFFFFFFF),
      onError: const Color(0xFF000000),
    ),
  );
}

ThemeData _lightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF607D8B), // Blue Grey as the seed color
      brightness: Brightness.light,
      primary: const Color(0xFF607D8B), // Blue Grey for primary
      secondary: const Color(0xFF90A4AE), // Lighter Blue Grey for secondary
      surface: const Color(0xFFECEFF1), // Light surface
      background: const Color(0xFFF0F0F0), // Very light background
      error: const Color(0xFFB00020), // Red variant for errors
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFF000000),
      onSurface: const Color(0xFF000000),
      onBackground: const Color(0xFF000000),
      onError: const Color(0xFFFFFFFF),
    ),
  );
}
