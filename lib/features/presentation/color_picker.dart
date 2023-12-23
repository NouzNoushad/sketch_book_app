import 'package:flutter/material.dart';

class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen(
      {super.key,
      required this.selectedColor,
      required this.currentIndex,
      required this.onColorChanged});

  final Color selectedColor;
  final int currentIndex;
  final Function(Color, int) onColorChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final colorIndex = index;
          return GestureDetector(
            onTap: () =>
                onColorChanged.call(Colors.primaries[colorIndex], colorIndex),
            child: AnimatedContainer(
              height: currentIndex == colorIndex ? 60 : 48,
              width: currentIndex == colorIndex ? 60 : 48,
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                  color: Colors.primaries[colorIndex],
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: Colors.black,
                  )),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
        itemCount: Colors.primaries.length);
  }
}
