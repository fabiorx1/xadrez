import 'package:flutter/material.dart';

class QuadradoUI extends StatelessWidget {
  const QuadradoUI(
      {super.key, required this.onTap, this.color = Colors.black54});
  final void Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
          onTap: onTap, child: Material(color: color, child: const Center())),
    );
  }
}
