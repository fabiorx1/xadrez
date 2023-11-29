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

  Peca({
    required this.tipo,
    required this.splashPath,
  });
}
