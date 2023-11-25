import 'periodictable.dart';

class Element {
  final String symbol;
  final String name;
  final String latinName;
  final int weight;

  Element({
    required this.symbol,
    required this.name,
    required this.latinName,
    required this.weight,
  }) {
    if (!isValidSymbol(symbol)) {
      throw Exception('Invalid symbol: $symbol');
    }
  }

  static bool isValidSymbol(String symbol) {
    var validSymbols = PeriodicTable.allSymbols;
    return validSymbols.contains(symbol);
  }

  factory Element.fromJson(Map<String, dynamic> jsonElement) {
    String symbol = jsonElement['symbol'];
    String name = jsonElement['name'];
    String latinName = jsonElement['latinName'];
    int weight = int.parse(jsonElement['weight']);

    return Element(
      symbol: symbol,
      name: name,
      latinName: latinName,
      weight: weight,
    );
  }
}
