import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sketch_book_app/features/models/sketch_book.dart';

import '../../../utils/colors.dart';

class SketchDrawingScreen extends StatelessWidget {
  const SketchDrawingScreen(
      {super.key,
      required this.onPanStart,
      required this.onPanUpdate,
      required this.onPanEnd,
      required this.sketches,
      required this.screenshotController});

  final void Function(DragStartDetails)? onPanStart;
  final void Function(DragUpdateDetails)? onPanUpdate;
  final void Function(DragEndDetails)? onPanEnd;
  final List<SketchBook> sketches;
  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(width: 4, color: ColorPicker.sketchBorderColor),
            ),
          ),
          Positioned.fill(
              child: Screenshot(
            controller: screenshotController,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(width: 4, color: ColorPicker.sketchBorderColor),
              ),
              child: CustomPaint(
                painter: SketchBookPainter(sketches: sketches),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class SketchBookPainter extends CustomPainter {
  SketchBookPainter({required this.sketches});
  final List<SketchBook> sketches;
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    double borderLength = 10.0;
    double borderWidth = 5.0;
    double margin = borderLength + borderWidth;
    for (var sketch in sketches) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = sketch.strokeWidth
        ..color = sketch.color;
      final path = Path();
      path.moveTo(sketch.offset[0].dx, sketch.offset[0].dy);
      for (var i = 0; i < sketch.offset.length; i++) {
        if (i + 1 < sketch.offset.length) {
          final offset1 = sketch.offset[i];
          final offset2 = sketch.offset[i + 1];
          path.quadraticBezierTo(
              offset1.dx, offset1.dy, offset2.dx, offset2.dy);
        }
      }
      canvas.clipRRect(RRect.fromRectAndRadius(
          Rect.fromLTRB(margin, margin, width - margin, height - margin),
          const Radius.circular(20)));
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(SketchBookPainter oldDelegate) {
    return false;
  }
}
