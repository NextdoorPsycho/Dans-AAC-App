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

  void _addGuide() {
    if (guideNameController.text.isNotEmpty) {
      final newGuide = Guide(
        id: UniqueKey().toString(),
        name: guideNameController.text,
        pages: [],
      );
      setState(() {
        guides.add(newGuide);
      });
      saveGuides();
    }
  }

  void _addPageToCurrentGuide() {
    if (pageTextController.text.isNotEmpty &&
        pageNumberController.text.isNotEmpty) {
      final page = GuidePage(
        text: pageTextController.text,
        number: int.tryParse(pageNumberController.text) ?? 0,
      );
      if (currentPageIndex < guides.length) {
        setState(() {
          guides[currentPageIndex].pages.add(page);
        });
        saveGuides();
      }
    }
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
      setState(() {
        guides = (json.decode(guidesJson) as List)
            .map((guideJson) => Guide.fromJson(guideJson))
            .toList();
      });
    }
  }

  void _openAddPageDrawer() {
    currentPageIndex =
        guides.length - 1; // Ensure we're on the last guide for editing
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
                      labelText: 'Page Text',
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
                      _addGuide(); // Save the guide or page changes
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
            // The add button at the end of the list
            return ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Create New Guide'),
              onTap: () {
                _openAddPageDrawer();
              },
            );
          }
          return ListTile(
            title: Text(guides[index].name),
            onTap: () {
              // Set current page index to the tapped guide
              setState(() {
                currentPageIndex = index;
                guideNameController.text = guides[index].name;
                if (guides[index].pages.isNotEmpty) {
                  pageTextController.text = guides[index].pages.first.text;
                  pageNumberController.text =
                      guides[index].pages.first.number.toString();
                }
              });
              _openAddPageDrawer(); // Open the drawer to edit the selected guide
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Reset controllers for adding a new guide
          guideNameController.clear();
          pageTextController.clear();
          pageNumberController.clear();
          _openAddPageDrawer(); // Open the drawer for a new guide
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
