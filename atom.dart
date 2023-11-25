import 'periodictable.dart';

class Atom {
  final String symbol;

  Atom(this.symbol) {
    if (!isValidSymbol(symbol)) {
      throw Exception('Invalid atom symbol: $symbol');
    }
  }

  static bool isValidSymbol(String symbol) {
    final validSymbols = PeriodicTable.allSymbols;
    return validSymbols.contains(symbol.toUpperCase());
  }

  @override
  String toString() {
    return symbol;
  }
}
