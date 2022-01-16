import 'package:best_flutter_ui_templates/PC_Builder/providers/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Hardware with ChangeNotifier {
// general values
  final String id;
  final String Manfacturer;
  final String Type;
  final String price;
  final String? Description;
  final double Rating;
  final Color color;
  final String Imageurl;
  final IconData icon;
  bool isFavorite;
  final List<String>? prop1;
  final List<String> prop2;
  final List<String> prop3;
  final SWHW swhw;

  // the wattage of each item
//     final int TDP;

// final Color color;
//   // not genral
//   // CPU
//   final int CoreCount;
//   final String Socket;
//   // the down two about the cooler fan
//   final double RPM;
//   final int NoiseLevel;

//   final String memorytype;
//    // motherboard this about the type of memory card
//   final int Memoryslot;
//   // motherboard this about the number of memory card
//   final double Voltage;
//   // storage of internal hardDrive
//   final int capacity;
//   // int storage and CPU
//   final int cache;

  Hardware({
    this.Description,
    required this.Manfacturer,
    this.Rating = 0.0,
    required this.Type,
    required this.id,
    required this.price,
    required this.color,
    required this.Imageurl,
    required this.icon,
    this.isFavorite = false,
    this.prop1 = const ['value', 'NOTV'],
    this.prop2 = const ['value', 'NOTV'],
    this.prop3 = const ['value', 'NOTV'],
    this.swhw = SWHW.hardware,
  });
  void togglefavoritestatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
