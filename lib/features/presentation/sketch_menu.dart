import 'package:flutter/material.dart';
import 'package:sketch_book_app/utils/extensions.dart';

class SketchBookMenuScreen extends StatelessWidget {
  const SketchBookMenuScreen(
      {super.key,
      required this.onUndo,
      required this.onRedo,
      required this.onDelete,
      required this.onErased,
      required this.onPencilSelected});
  final void Function()? onUndo;
  final void Function()? onRedo;
  final void Function()? onDelete;
  final Function(double?)? onErased;
  final Function(double?)? onPencilSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onUndo,
            child: Image.asset(
              'assets/undo.png',
              color: Colors.purple,
              height: context.height * 0.12,
              width: context.width * 0.12,
            ),
          ),
          GestureDetector(
            onTap: onRedo,
            child: Image.asset(
              'assets/redo.png',
              color: Colors.purple,
              height: context.height * 0.12,
              width: context.width * 0.12,
            ),
          ),
          PopupMenuButton(
            onSelected: (value) => onPencilSelected?.call(value.toDouble()),
            itemBuilder: (context) {
              return popupMenuItems;
            },
            child: Image.asset(
              'assets/pencil.png',
              height: context.height * 0.12,
              width: context.width * 0.12,
            ),
          ),
          PopupMenuButton(
            onSelected: (value) => onErased?.call(value.toDouble()),
            itemBuilder: (context) {
              return popupMenuItems;
            },
            child: Image.asset(
              'assets/eraser.png',
              height: context.height * 0.12,
              width: context.width * 0.12,
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: Image.asset(
              'assets/delete.png',
              height: context.height * 0.12,
              width: context.width * 0.12,
            ),
          ),
        ],
      ),
    );
  }
}

List<PopupMenuItem<int>> popupMenuItems = [
  const PopupMenuItem(value: 5, child: Text('5')),
  const PopupMenuItem(value: 10, child: Text('10')),
  const PopupMenuItem(value: 20, child: Text('20')),
  const PopupMenuItem(value: 30, child: Text('30')),
  const PopupMenuItem(value: 40, child: Text('40')),
  const PopupMenuItem(value: 50, child: Text('50')),
];
