import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sketch_book_app/features/models/sketch_book.dart';
import 'package:uuid/uuid.dart';

import 'color_picker.dart';
import 'sketch_drawing.dart';
import 'sketch_menu.dart';

class SketchHomeScreen extends StatefulWidget {
  const SketchHomeScreen({super.key});

  @override
  State<SketchHomeScreen> createState() => _SketchHomeScreenState();
}

class _SketchHomeScreenState extends State<SketchHomeScreen> {
  SketchBook? selectedSketch;
  late List<SketchBook> sketches;
  late List<SketchBook> undoSketches;
  late List<SketchBook> redoSketches;
  int selectedIndex = 0;
  late Color selectedColor;
  late double strokeWidth;
  late ScreenshotController screenshotController;

  @override
  void initState() {
    sketches = [];
    undoSketches = [];
    redoSketches = [];
    selectedColor = Colors.primaries[0];
    strokeWidth = 3;
    screenshotController = ScreenshotController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sketch Book'),
        actions: [
          IconButton(
              onPressed: () {
                screenshotController.capture().then((image) async {
                  String fileName =
                      "sketchbook_${DateTime.now().microsecondsSinceEpoch}";
                  if (image != null) {
                    await ImageGallerySaver.saveImage(image,
                        name: fileName, isReturnImagePathOfIOS: true);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.purple,
                          content: Text(
                            'Image saved to Gallery',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )));
                    }
                  }
                }).catchError((error){
                  debugPrint(error);
                });
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Column(children: [
        Expanded(
            flex: 6,
            child: SketchDrawingScreen(
              screenshotController: screenshotController,
              sketches: sketches,
              onPanStart: (details) {
                setState(() {
                  selectedSketch = SketchBook(
                      id: const Uuid().v4(),
                      offset: [details.localPosition],
                      color: selectedColor,
                      strokeWidth: strokeWidth);
                  sketches.add(selectedSketch!);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  selectedSketch?.offset.add(details.localPosition);
                  final sketch = sketches.firstWhere(
                      (element) => element.id == selectedSketch?.id);
                  sketches[sketches.indexOf(sketch)] =
                      sketch.copyWith(offset: selectedSketch?.offset);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  selectedSketch = null;
                });
              },
            )),
        Expanded(
          child: ColorPickerScreen(
            selectedColor: selectedColor,
            currentIndex: selectedIndex,
            onColorChanged: (color, index) {
              setState(() {
                selectedColor = color;
                selectedIndex = index;
              });
            },
          ),
        ),
        Expanded(
          child: SketchBookMenuScreen(
            onUndo: () {
              if (sketches.isNotEmpty) {
                setState(() {
                  final sketch = sketches.removeLast();
                  undoSketches.add(sketch);
                });
              }
            },
            onRedo: () {
              if (undoSketches.isNotEmpty) {
                setState(() {
                  final sketch = undoSketches.removeLast();
                  sketches.add(sketch);
                });
              }
            },
            onDelete: () {
              setState(() {
                sketches.clear();
                selectedSketch = null;
              });
            },
            onErased: (value) {
              setState(() {
                strokeWidth = value ?? strokeWidth;
                selectedColor = Colors.white;
              });
            },
            onPencilSelected: (value) {
              setState(() {
                strokeWidth = value ?? strokeWidth;
                selectedColor = Colors.primaries[selectedIndex];
              });
            },
          ),
        ),
      ]),
    );
  }
}
