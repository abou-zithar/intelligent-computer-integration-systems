import 'package:best_flutter_ui_templates/PC_Builder/providers/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Software with ChangeNotifier {
      // String productId,
      // String title,
      // String imagepath,
      // String overhead,
      // double rating,
      // List<String> prop1,
      // List<String> version
  Software({
    required this.id,
    this.title = '',
    required this.version,
    this.imagePath = '',
    this.discription = '',
    this.rating = 0.0,
    this.color = Colors.orange,
    this.price = '0.0',
    this.prop1,
    this.prop2,
    this.prop3,
    this.isFavorite = false,
    this.swhw = SWHW.software,
  });

  void togglefavoritestatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  final String id;
  final String title;
  final String version;
  final String discription;
  final double rating;
  final String price;
  final String imagePath;
  final Color color;
  bool isFavorite;
  final List<String>? prop1;
  final List<String>? prop2;
  final List<String>? prop3;
  final SWHW swhw;
}
