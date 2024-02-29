import 'dart:convert';

import 'package:dans_aac_app/guide/object_guide.dart';
import 'package:dans_aac_app/guide/object_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuidePageViewport extends StatefulWidget {
  const GuidePageViewport({super.key});

  @override
  State<GuidePageViewport> createState() => _GuidePageViewportState();
}

class _GuidePageViewportState extends State<GuidePageViewport> {
  late TextEditingController guideNameController;
  late TextEditingController pageTextController;
  late TextEditingController pageNumberController;
  int currentPageIndex = 0;
  List<Guide> guides = [];
  bool isNewGuide = false;

  @override
  void initState() {
    super.initState();
    guideNameController = TextEditingController();
    pageTextController = TextEditingController();
    pageNumberController = TextEditingController();
    loadGuides();
  }

  @override
  void dispose() {
    guideNameController.dispose();
    pageTextController.dispose();
    pageNumberController.dispose();
    super.dispose();
  }

  void _addOrUpdateGuide() {
    if (guideNameController.text.isNotEmpty) {
      if (isNewGuide) {
        final newGuide = Guide(
          id: UniqueKey().toString(),
          name: guideNameController.text,
          pages: [
            GuidePage(
              text: pageTextController.text,
              number: int.parse(pageNumberController.text),
            )
          ],
        );
        setState(() {
          guides.add(newGuide);
        });
        isNewGuide = false;
      } else {
        GuidePage newPage = GuidePage(
          text: pageTextController.text,
          number: int.parse(pageNumberController.text),
        );

        setState(() {
          guides[currentPageIndex].name = guideNameController.text;
          guides[currentPageIndex].pages.add(newPage);
        });
      }

      saveGuides();
    }
  }

  void _deleteGuide(int guideIndex) {
    setState(() {
      guides.removeAt(guideIndex);
    });
    saveGuides();
  }

  Future<void> saveGuides() async {
    final prefs = await SharedPreferences.getInstance();
    final String guidesJson =
        json.encode(guides.map((guide) => guide.toJson()).toList());
    await prefs.setString('guides', guidesJson);
  }

  Future<void> loadGuides() async {
    final prefs = await SharedPreferences.getInstance();
    final String? guidesJson = prefs.getString('guides');
    if (guidesJson != null) {
      final decodedJson = json.decode(guidesJson);
      // Check if the decoded JSON is a Map and contains a key for guides
      if (decodedJson is Map<String, dynamic> &&
          decodedJson.containsKey('guides')) {
        setState(() {
          guides = (decodedJson['guides'] as List)
              .map((guideJson) => Guide.fromJson(guideJson))
              .toList();
        });
      } else if (decodedJson is List) {
        setState(() {
          guides = decodedJson
              .map((guideJson) => Guide.fromJson(guideJson))
              .toList();
        });
      }
    }
  }

  void _openAddOrUpdatePageDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    controller: guideNameController,
                    decoration: const InputDecoration(
                      labelText: 'Guide Name',
                    ),
                  ),
                  TextField(
                    controller: pageTextController,
                    decoration: const InputDecoration(
                      labelText: 'Some Text',
                    ),
                  ),
                  TextField(
                    controller: pageNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Page Number',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addOrUpdateGuide();
                      Navigator.pop(context); // Close the modal bottom sheet
                    },
                    child: const Text('Save Guide'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guides'),
      ),
      body: ListView.builder(
        itemCount: guides.length + 1, // +1 for the add button
        itemBuilder: (context, index) {
          if (index == guides.length) {
            return ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Create New Guide'),
              onTap: () {
                guideNameController
                    .clear(); // Clear the controller for new guide creation
                pageTextController.clear();
                pageNumberController.clear();
                isNewGuide = true;
                _openAddOrUpdatePageDrawer();
              },
            );
          }
          return ListTile(
            title: Text(guides[index].name),
            leading: const Icon(Icons.book),
            trailing: IconButton(
              // Adding delete guide button here
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteGuide(index);
              },
            ),
            onTap: () {
              currentPageIndex = index;
              guideNameController.text = guides[index].name;
              if (guides[index].pages.isNotEmpty) {
                pageTextController.text = guides[index].pages.last.text;
                pageNumberController.text =
                    guides[index].pages.last.number.toString();
              }
              _openAddOrUpdatePageDrawer();
            },
          );
        },
      ),
    );
  }
}
