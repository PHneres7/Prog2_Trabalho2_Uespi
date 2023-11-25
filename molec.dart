import 'periodictable.dart';
import 'element.dart';
import 'package:string_validator/string_validator.dart' as str;

class Molecule implements Comparable<Molecule> {
  final String formula;
  final String name;

  Molecule({
    required this.formula,
    required this.name,
  }) {
    isValidFormula();
  }

  List<Map<String, dynamic>> formatedFormula() {
    var splittedFormula = formula.split('');
    var splittedAndFormatedFormula = <Map<String, dynamic>>[];

    do {
      String currentCharacter = splittedFormula[0];
      if (str.isAlpha(currentCharacter) && str.isUppercase(currentCharacter)) {
        splittedAndFormatedFormula.add({'symbol': currentCharacter});
        splittedFormula.removeAt(0);
      } else if (str.isAlpha(currentCharacter)) {
        splittedAndFormatedFormula.last['symbol'] += currentCharacter;
        splittedFormula.removeAt(0);
      } else {
        if (!splittedAndFormatedFormula.last.containsKey('weightMultiplier')) {
          splittedAndFormatedFormula.last['weightMultiplier'] =
              currentCharacter;
        } else {
          splittedAndFormatedFormula.last['weightMultiplier'] +=
              currentCharacter;
        }
        splittedFormula.removeAt(0);
      }
    } while (splittedFormula.isNotEmpty);
    return splittedAndFormatedFormula;
  }

  bool isValidFormula() {
    for (var char in formatedFormula()) {
      if (!PeriodicTable.elements.containsKey(char['symbol'])) {
        return false;
      }
    }
    return true;
  }

  int get weight {
    int totalWeight = 0;
    for (var char in formatedFormula()) {
      var symbol = char['symbol'];
      var multiplier = char['weightMultiplier'] != null
          ? int.parse(char['weightMultiplier'])
          : 1;
      totalWeight += _currentAtomWeight(symbol) * multiplier;
    }
    return totalWeight;
  }

  int _currentAtomWeight(String currentSymbol) {
    var element = PeriodicTable.elements[currentSymbol];
    return element != null ? element.weight : 0;
  }

  @override
  int compareTo(Molecule other) {
    return this.weight.compareTo(other.weight);
  }

  Element getElement(String symbol) {
    final element = PeriodicTable.elements[symbol];

    if (element == null) {
      throw Exception(
          'Element symbol not found in the Periodic Table: $symbol');
    }

    return element;
  }
}
