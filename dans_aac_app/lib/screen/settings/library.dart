import 'package:dans_aac_app/widget/inoperable/basic_container.dart';
import 'package:dans_aac_app/widget/inoperable/text.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
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
        title: basicTitle("Library Page", context),
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
      basicTitle("Library Page", context),
      basicSubtext("This is the library page", context),
    ]);
  }
}
