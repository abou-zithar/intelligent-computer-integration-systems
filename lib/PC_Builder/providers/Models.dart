// import 'dart:ffi';
import 'package:best_flutter_ui_templates/PC_Builder/providers/Hardware.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'createPC.dart';

import 'package:provider/provider.dart';

class ModelProvider with ChangeNotifier {
  ModelProvider({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.price,
    this.discription = '',
    required this.rating,
    required this.color,
    required this.type,
    this.overhead,
    this.prop1 = const ['value', 'NOTV'],
    this.prop2 = const ['value', 'NOTV'],
    this.prop3 = const ['value', 'NOTV'],
  });

  final String title;
  final String price;
  final String discription;
  final double rating;
  final String imagePath;
  final Color color;
  final String id;
  final SWHW type;
  final String? overhead;
  final List<String>? prop1;
  final List<String>? prop2;
  final List<String>? prop3;
}

class Models with ChangeNotifier {
  Map<String, ModelProvider>? _items = {};
  Map<String, ModelProvider> get items {
    return {..._items!};
  }

  void addItem(
      String productId,
      String price,
      String title,
      double rating,
      String imagepath,
      Color color,
      SWHW type,
      String? overhead,
      final List<String>? prop1,
      final List<String>? prop2,
      final List<String>? prop3) {
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
            type: type,
            prop1: prop1,
            prop2: prop2,
            prop3: prop3),
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
              type: type,
              overhead: overhead));
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

  //-----------------------
//the main algo of the program
//------------------------------
  void createPC(List<ModelProvider> pcItemsList) {
    var functionsTocreatePC = new CreatePc();

    List<ModelProvider>? hardware;

    var applications_final_weight;

    var hardWare_Type;

    for (int i = 0; i < pcItemsList.length; i++) {
      if (pcItemsList[i].type == SWHW.software) {
        // the value that i will filter base on it

        applications_final_weight =
            functionsTocreatePC.findfilter(pcItemsList[i].overhead);
      } else if (pcItemsList[i].type == SWHW.hardware) {
        // to find the type of each pcItem by prop1
        hardWare_Type = functionsTocreatePC.findType(pcItemsList[i].prop1);
// after knowing the type we put every hardware items with the same type in the same list
        functionsTocreatePC.filter_Hardware(pcItemsList[i], hardWare_Type);
// call complete lsits function to enhance the lists to make them ready for the next step
        functionsTocreatePC.completeHardware_lists();
      }
    }

    // for (int i = 0; i < pcItemsList.length; i++) {
    //   if (pcItemsList[i].type == SWHW.hardware) {

    //   }
    // }
  }
}

enum SWHW { software, hardware }
