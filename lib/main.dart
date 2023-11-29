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
  final Color selectedColor = Colors.orange;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final List<QuadradoUI> quadrados;

  final Peca peao = Peca(
    splashPath: 'peao.png',
    tipo: TipoPeca.peao,
  );
  int? selected;

  @override
  void initState() {
    quadrados = [
      for (int i = 0; i < 8 * 8; i++)
        QuadradoUI(
          onTap: () {},
          p: i == 17 ? peao : null,
        ),
    ];
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
          child: tabuleiro(),
        ));
  }

  GridView tabuleiro() =>
      GridView.count(crossAxisCount: 8, children: quadrados);
}
