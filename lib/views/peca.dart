import 'package:flutter/material.dart';
import 'package:xadrez/peca.dart';

class QuadradoUI extends StatefulWidget {
  const QuadradoUI({
    super.key,
    required this.onTap,
    this.color = Colors.black54,
    this.p,
  });
  final void Function() onTap;
  final Color color;
  final Peca? p;

  @override
  State<QuadradoUI> createState() => _QuadradoUIState();
}

class _QuadradoUIState extends State<QuadradoUI> {
  late Color color;
  late Color colorBright;

  @override
  void initState() {
    color = widget.color;
    colorBright = Color.lerp(widget.color, Colors.white, .3) ?? color;
    super.initState();
  }

  void shineBright() => setState(() => color = colorBright);
  void stayChill() => setState(() => color = widget.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
            onEnter: (_) => shineBright(),
            onExit: (_) => stayChill(),
            child: Material(
              color: color,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 0.5,
                  child: widget.p != null
                      ? Image.asset(widget.p!.splashPath)
                      : const Center(),
                ),
              ), // here goes the peça icon
            )),
      ),
    );
  }
}
