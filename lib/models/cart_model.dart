import 'package:flutter/material.dart';
import 'item.dart';

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => List.unmodifiable(_items);

  int get totalPrice {
    int total = 0;

    for (final item in _items) {
      total += item.price;
    }

    return total;
  }

  bool contains(Item item) {
    return _items.any((cartItem) => cartItem.id == item.id);
  }

  void add(Item item) {
    if (!contains(item)) {
      _items.add(item);
      notifyListeners();
    }
  }

  void remove(Item item) {
    _items.removeWhere((cartItem) => cartItem.id == item.id);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}