// import 'dart:ffi';

import '../providers/Hardware_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ModelProvider with ChangeNotifier {
  ModelProvider(
      {required this.id,
      required this.title,
      required this.imagePath,
      required this.price,
      this.discription = '',
      required this.rating,
      required this.color,
      required this.type});

  final String title;
  final String price;
  final String discription;
  final double rating;
  final String imagePath;
  final Color color;
  final String id;
  final SWHW type;
}

class Models with ChangeNotifier {
  Map<String, ModelProvider>? _items = {};
  Map<String, ModelProvider> get items {
    return {..._items!};
  }

  void addItem(String productId, String price, String title, double rating,
      String imagepath, Color color, SWHW type) {
    if (type == SWHW.hardware) {
      _items!.putIfAbsent(
        productId,
        () => ModelProvider(
            id: productId,
            title: title,
            price: price,
            rating: rating,
            imagePath: imagepath,
            color: color,
            type: type),
      );
    } else if (type == SWHW.software) {
      _items!.putIfAbsent(
          productId,
          () => ModelProvider(
              id: productId,
              title: title,
              price: '0',
              rating: rating,
              imagePath: imagepath,
              color: color,
              type: type));
      print('${items.length}');
    }
    notifyListeners();
  }

  void removeItem(String productid) {
    _items!.remove(productid);
    notifyListeners();
  }

  int get itemCount {
    Map<String, ModelProvider>? items;
    return items == null ? 0 : items.length;
  }
}

enum SWHW { software, hardware }
