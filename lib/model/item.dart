import 'package:flutter/material.dart';

class Items {
  final DateTime date;
  final List<Item> items;

  Items({
    @required this.date,
    @required this.items,
  });

  Map<String, dynamic> toJson() {
    final itemsJson = items.map((i) => i.toJson()).toList();

    return {
      "date": date.toString(),
      "items": itemsJson,
    };
  }

  static Items fromJson(Map<String, dynamic> json) {
    final itemsJson = (json['items']).map<Item>((i) {
      return Item.fromJson(i);
    }).toList();

    return Items(
      date: DateTime.parse(json['date']),
      items: itemsJson,
    );
  }
}

class Item {
  final int item;

  Item({this.item});

  Map<String, dynamic> toJson() {
    return {
      "item": item,
    };
  }

  static Item fromJson(Map<String, dynamic> json) {
    return Item(
      item: json['item'] as int,
    );
  }
}
