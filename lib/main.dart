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
  final Peca peao = Peca(splashPath: 'peao.png', tipo: TipoPeca.peao);
  late final Map<int, Peca> pecas = {17: peao};
  int? selected;

  @override
  void initState() {
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
              color: i == selected ? widget.selectedColor : null,
              onTap: () => onClick(i),
              p: pecas.containsKey(i) ? pecas[i] : null,
            ),
        ])));
  }

  void onClick(int i) {
    debugPrint('$i');
    if (selected == i) {
      setState(() => selected = null);
    } else if (selected != null) {
      onClickMove(i);
      return;
    } else {
      setState(() => selected = i);
    }
  }

  void onClickMove(int i) {
    debugPrint("Move");
  }
}
