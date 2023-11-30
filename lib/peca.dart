enum TipoPeca {
  peao,
  bispo,
  cavalo,
  rei,
  rainha,
  torre,
}

class Peca {
  final TipoPeca tipo;
  final String splashPath;
  final bool isW;

  Peca({
    required this.tipo,
    required this.splashPath,
    this.isW = false,
  });
}
