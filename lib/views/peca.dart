import 'package:flutter/material.dart';
import 'package:xadrez/peca.dart';

class QuadradoUI extends StatelessWidget {
  const QuadradoUI({
    super.key,
    required this.onTap,
    this.color,
    this.p,
  });
  final void Function() onTap;
  final Color? color;
  final Peca? p;
  final bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          color: color ?? Colors.black38,
          child: Center(
            child: AspectRatio(
              aspectRatio: 0.5,
              child: p != null ? Image.asset(p!.splashPath) : const Center(),
            ),
          ), // here goes the peça icon
        ),
      ),
    );
  }
}
