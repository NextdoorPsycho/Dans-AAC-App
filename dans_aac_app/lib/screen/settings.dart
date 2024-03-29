import 'package:dans_aac_app/model/app/app_data_model.dart';
import 'package:dans_aac_app/widget/inoperable/basic_container.dart';
import 'package:dans_aac_app/widget/inoperable/text.dart';
import 'package:dans_aac_app/widget/notification/notification.dart';
import 'package:dans_aac_app/widget/operable/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsViewport extends StatefulWidget {
  const SettingsViewport({super.key});

  @override
  State<SettingsViewport> createState() => _SettingsViewportState();
}

class _SettingsViewportState extends State<SettingsViewport> {
  late TextEditingController apiTokenController; // for the text field

  @override
  void initState() {
    super.initState();
    apiTokenController = TextEditingController();
  }

  @override
  void dispose() {
    apiTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: basicTitle("Settings Page", context),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPage(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return basicContainer(context, [
      basicTitle("Settings Page", context),
      basicSubtext("This is the settings page", context),
      customSwitchTile(
          title: Theme.of(context).brightness == Brightness.dark
              ? "Light Mode"
              : "Dark Mode",
          value: Theme.of(context).brightness == Brightness.dark,
          onChanged: (bool value) {
            // Toggle theme logic here
            Provider.of<AppDataModel>(context, listen: false).toggleTheme();
            genericNotification(context, "Toggled the theme!",
                "I bet you like dark theme you dirty little vegetable.",
                time: 3);
          },
          context: context)
    ]);
  }
}
