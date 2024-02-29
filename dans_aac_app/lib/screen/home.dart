import 'package:dans_aac_app/widget/inoperable/basic_container.dart';
import 'package:dans_aac_app/widget/inoperable/text.dart';
import 'package:flutter/material.dart';

class HomeViewport extends StatefulWidget {
  const HomeViewport({super.key});

  @override
  State<HomeViewport> createState() => _HomeViewportState();
}

class _HomeViewportState extends State<HomeViewport> {
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
        title: basicTitle("Home Page", context),
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
    return basicContainer(context, [
      basicTitle("Home Page", context),
      basicSubtext("This is the home page", context),
    ]);
  }
}
