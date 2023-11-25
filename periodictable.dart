import 'dart:convert';
import 'dart:io';
import 'element.dart';

class PeriodicTable {
  static Map<String, Element>? _elements;
  static List<String>? _allSymbols;

  static Map<String, Element> get elements {
    _initializeIfNeeded();
    return _elements ?? {};
  }

  static List<String> get allSymbols {
    _initializeIfNeeded();
    return _allSymbols ?? [];
  }

  static void _initializeIfNeeded() {
    if (_elements == null || _allSymbols == null) {
      _initialize();
    }
  }

  static void _initialize() {
    try {
      var jsonData =
          jsonDecode(File('elements.json').readAsStringSync()) as List<dynamic>;
      _elements = _fillWithAllElements(jsonData);
      _allSymbols = symbolFinder();
    } catch (e) {
      print('Error loading periodic table data: $e');
      
    }
  }

  static Map<String, Element> _fillWithAllElements(List<dynamic> jsonData) {
    Map<String, Element> listWithAllElements = {};
    var count = 1;
    for (int i = 0; i < jsonData.length; i++) {
      var c = jsonData[i];
      
      listWithAllElements[count.toString()] = Element(
          symbol: c['symbol'],
          name: c['name'],
          latinName: c['latinName'],
          weight: int.parse(c['weight']));
      count++;
    }
    return listWithAllElements;
  }

  static List<String> symbolFinder() {
    List<String> completeListofSymbols = [];

    _elements!.forEach((key, value) {
      completeListofSymbols.add(value.symbol);
    });

    return completeListofSymbols;
  }
}