import 'package:flutter/material.dart';

enum LikeDissType {
  like,
  diss,
}

class LikeDissLabel extends StatelessWidget {
  const LikeDissLabel({
    Key? key,
    required this.type,
    required this.opacity,
  }) : super(key: key);

  final LikeDissType type;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final color = type == LikeDissType.like ? Colors.green : Colors.red;
    final textStyle = TextStyle(fontSize: 52, fontWeight: FontWeight.w800, color: color);
    final text = type == LikeDissType.like ? 'LIKE' : 'NOPE';

    return Positioned(
        left: type == LikeDissType.like ? 1 : null,
        right: type == LikeDissType.diss ? 1 : null,
        child: Opacity(
            opacity: opacity,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color,
                  width: 4,
                ),
              ),
              child: Text(
                text,
                style: textStyle,
              ),
            )));
  }
}
