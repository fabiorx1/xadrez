import 'package:flutter/material.dart';
import 'package:xadrez/peca.dart';
import 'package:xadrez/views/peca.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xadrez dos Manitos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Jogo de Xadrez'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  final Color selectedColor = Colors.purple;
  final Color moveColor = Colors.green;
  final Color c1 = Colors.red;
  final Color c2 = Colors.blue;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Peca peaoP = Peca(splashPath: 'peao-p.png', tipo: TipoPeca.peao);
  final Peca torreP = Peca(splashPath: 'torre-p.png', tipo: TipoPeca.torre);
  final Peca cavaloP = Peca(splashPath: 'cavalo-p.png', tipo: TipoPeca.torre);
  final Peca bispoP = Peca(splashPath: 'bispo-p.png', tipo: TipoPeca.torre);
  final Peca reiP = Peca(splashPath: 'rei-p.png', tipo: TipoPeca.torre);
  final Peca rainhaP = Peca(splashPath: 'rainha-p.png', tipo: TipoPeca.torre);

  final Peca peaoW =
      Peca(splashPath: 'peao-b.png', tipo: TipoPeca.peao, isW: true);
  final Peca torreW =
      Peca(splashPath: 'torre-b.png', tipo: TipoPeca.torre, isW: true);
  final Peca cavaloW =
      Peca(splashPath: 'cavalo-b.png', tipo: TipoPeca.torre, isW: true);
  final Peca bispoW =
      Peca(splashPath: 'bispo-b.png', tipo: TipoPeca.torre, isW: true);
  final Peca reiW =
      Peca(splashPath: 'rei-b.png', tipo: TipoPeca.torre, isW: true);
  final Peca rainhaW =
      Peca(splashPath: 'rainha-b.png', tipo: TipoPeca.torre, isW: true);

  late final triadeP = [torreP, cavaloP, bispoP];
  late final triadeW = [torreW, cavaloW, bispoW];
  late final seqP = <Peca>[
    ...triadeP,
    reiP,
    rainhaP,
    ...triadeP.reversed,
    ...[for (int j = 0; j < 8; j++) peaoP]
  ];
  late final seqW = <Peca>[
    ...[for (int j = 0; j < 8; j++) peaoW],
    ...triadeW,
    reiW,
    rainhaW,
    ...triadeW.reversed,
  ];

  late final Map<int, Peca> pecas = {};
  List<int> allowedMoves = [];
  int? selected;

  @override
  void initState() {
    pecas.addAll({25: torreW, 35: torreP, 28: peaoP, 3: peaoW});
    // int index = 0;
    // for (final p in seqP) {
    //   pecas.addAll({index: p});
    //   index += 1;
    // }
    // index = 6 * 8;
    // for (final p in seqW) {
    //   pecas.addAll({index: p});
    //   index += 1;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: GridView.count(crossAxisCount: 8, children: [
          for (int i = 0; i < 8 * 8; i++)
            QuadradoUI(
              key: ValueKey(i),
              color: tileColor(i),
              onTap: () => onClick(i),
              p: pecas.containsKey(i) ? pecas[i] : null,
            ),
        ])));
  }

  Color tileColor(int i) {
    if (selected == i) return widget.selectedColor;
    if (allowedMoves.contains(i)) return widget.moveColor;
    if (getY(i) % 2 == 0 && i % 2 == 0) return widget.c2;
    if (getY(i) % 2 == 1 && i % 2 == 1) return widget.c2;
    return widget.c1;
  }

  void onClick(int i) {
    if (selected == i) {
      setState(() {
        selected = null;
        allowedMoves = [];
      });
    } else if (selected != null) {
      onClickMove(i);
      return;
    } else {
      setState(() {
        selected = i;
        allowedMoves = getAllowedMoves(i);
      });
    }
  }

  void onClickMove(int i) {
    debugPrint("Move");
  }

  int getX(int i) => i % 8;
  int getY(int i) => i ~/ 8;
  int getPos(int x, int y) => y * 8 + x;

  List<int> getAllowedMoves(int i) {
    final x = getX(i);
    final y = getY(i);
    final peca = pecas[i]!;
    final moves = <int>[];
    switch (peca.tipo) {
      case TipoPeca.peao:
        final row = (peca.isW ? (y - 1) : (y + 1)) * 8;
        final front = row + x;
        final frontright = row + x + 1;
        final frontleft = row + x - 1;

        if (!pecas.containsKey(front)) moves.add(front);
        for (final pos in [frontleft, frontright]) {
          if (pecas.containsKey(pos) && pecas[pos]!.isW != peca.isW) {
            moves.add(pos);
          }
        }
        break;
      case TipoPeca.bispo:
      // TODO: Handle this case.
      case TipoPeca.cavalo:
      // TODO: Handle this case.
      case TipoPeca.rei:
      // TODO: Handle this case.
      case TipoPeca.rainha:
        straightMoves(y, x, peca, moves);
      case TipoPeca.torre:
        straightMoves(y, x, peca, moves);
    }
    return moves;
  }

  void straightMoves(int y, int x, Peca peca, List<int> moves) {
    for (int j = y + 1; j < 8; j++) {
      if (pecas.containsKey(8 * j + x)) {
        if (pecas[8 * j + x]!.isW != peca.isW) moves.add(8 * j + x);
        break;
      }
      moves.add(8 * j + x);
    }
    for (int j = y - 1; j >= 0; j--) {
      if (pecas.containsKey(8 * j + x)) {
        if (pecas[8 * j + x]!.isW != peca.isW) moves.add(8 * j + x);
        break;
      }
      moves.add(8 * j + x);
    }

    for (int k = x + 1; k < 8; k++) {
      if (pecas.containsKey(8 * y + k)) {
        if (pecas[8 * y + k]!.isW != peca.isW) {
          moves.add(8 * y + k);
        }
        break;
      }
      moves.add(8 * y + k);
    }
    for (int k = x - 1; k >= 0; k--) {
      if (pecas.containsKey(8 * y + k)) {
        if (pecas[8 * y + k]!.isW != peca.isW) moves.add(8 * y + k);
        break;
      }
      moves.add(8 * y + k);
    }
  }
}
