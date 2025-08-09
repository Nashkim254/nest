import 'package:flutter/material.dart';

class ProgressSegment {
  final double value;
  final Color color;
  final String? label;

  ProgressSegment({
    required this.value,
    required this.color,
    this.label,
  });
}
