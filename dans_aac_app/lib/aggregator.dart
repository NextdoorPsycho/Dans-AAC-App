import 'package:dans_aac_app/screen/guide.dart';
import 'package:dans_aac_app/screen/home.dart';
import 'package:dans_aac_app/screen/library.dart';
import 'package:dans_aac_app/screen/settings.dart';
import 'package:dans_aac_app/widget/inoperable/text.dart';
import 'package:flutter/material.dart';

class Aggregator extends StatefulWidget {
  const Aggregator({super.key});

  @override
  State<Aggregator> createState() => _AggregatorState();
}

class _AggregatorState extends State<Aggregator> {
  int selectedIndex = 0;

  Widget _getPageWidget(int index) {
    switch (index) {
      case 0:
        return const HomeViewport();
      case 1:
        return const LibraryViewport();
      case 2:
        return const SettingsViewport();
      case 3:
        return const GuidePageViewport();
      default:
        throw UnimplementedError('no widget for $index');
    }
  }

  Widget _buildMobileLayout(BuildContext context, Widget mainArea) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Expanded(child: mainArea),
        BottomNavigationBar(
          selectedLabelStyle: myTextStyle(context),
          unselectedLabelStyle: myTextStyle(context),
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: 'Home',
                backgroundColor: theme.primaryColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.local_library_outlined),
                label: 'Library',
                backgroundColor: theme.primaryColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings_outlined),
                label: 'Settings',
                backgroundColor: theme.primaryColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.help_outline),
                label: 'Guide',
                backgroundColor: theme.primaryColor),
          ],
          currentIndex: selectedIndex,
          onTap: (value) => setState(() => selectedIndex = value),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(
      BuildContext context, Widget mainArea, double width) {
    Theme.of(context);
    return Row(
      children: [
        SafeArea(
          child: NavigationRail(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
            indicatorColor: Theme.of(context).primaryColor,
            indicatorShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1.0))),
            destinations: [
              NavigationRailDestination(
                  icon: const Icon(Icons.home_outlined),
                  label: basicSubtext("Home", context)),
              NavigationRailDestination(
                icon: const Icon(Icons.local_library_outlined),
                label: basicSubtext("Library", context),
              ),
              NavigationRailDestination(
                  icon: const Icon(Icons.settings_outlined),
                  label: basicSubtext("Settings", context)),
              NavigationRailDestination(
                  icon: const Icon(Icons.help_outline),
                  label: basicSubtext("Guide", context)),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) =>
                setState(() => selectedIndex = value),
          ),
        ),
        Expanded(child: mainArea),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var page = _getPageWidget(selectedIndex);

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200), child: page),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth < 450
            ? _buildMobileLayout(context, mainArea)
            : _buildTabletLayout(context, mainArea, constraints.maxWidth),
      ),
    );
  }
}
