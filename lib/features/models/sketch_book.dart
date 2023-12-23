import 'package:flutter/material.dart';

class SketchBook {
  SketchBook({
    required this.id,
    required this.offset,
    required this.color,
    required this.strokeWidth,
  });

  final String id;
  final List<Offset> offset;
  final Color color;
  final double strokeWidth;

  SketchBook copyWith({
    String? id,
    List<Offset>? offset,
    Color? color,
    double? strokeWidth,
  }) {
    return SketchBook(
        id: id ?? this.id,
        offset: offset ?? this.offset,
        color: color ?? this.color,
        strokeWidth: strokeWidth ?? this.strokeWidth);
  }
}
