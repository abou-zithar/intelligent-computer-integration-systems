import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';

import 'Hardware.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class hardware with ChangeNotifier {
  List<Hardware> _item = [];

  var _showFavoritesOnly = false;

  List<Hardware> get items {
    if (_showFavoritesOnly) {
      return _item.where((element) => element.isFavorite).toList();
    }
    return [..._item];
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  var rng = new Random();
  var rating;
  // get the data of cpu
  void catchcpu() async {
    // print('here');
    CollectionReference hardwareref =
        FirebaseFirestore.instance.collection('CPU_2');
    var quearySnapShot = await hardwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        rating = rng.nextDouble() * 5;
        // print(element.data());
        addhardware(
            element.id,
            element.get('Price') as String,
            element.get('Released') as String,
            element.get('Name') as String,
            rating,
            [element.get('Cores') as String, 'Cores'],
            [element.get('TDP') as String, 'TDP'],
            [element.get('Socket') as String, 'Socket'],
            element.get('Clock'),
            'assets/new_images/chip.png');
      } else {
        print('not exist');
      }
    });

    catchGpu();
  }

  

  // get the data of gpu
  void catchGpu() async {
    // print('here');
    CollectionReference hardwareref =
        FirebaseFirestore.instance.collection('GPU');
    var quearySnapShot = await hardwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        var randomm = rng.nextDouble();
        if (randomm > .5) {
          rating = rng.nextDouble() + 4;
        } else {
          rating = rng.nextDouble() + 3;
        }
        // print(element.data());
        addhardware(
            element.id,
            element.get('Price') as String,
            element.get('Released') as String,
            element.get('Product_Name') as String,
            rating,
            [element.get('GPU_Chip') as String, 'Chip'],
            [element.get('GPU_Clock') as String, 'Clock'],
            [element.get('Memory') as String, 'Memory'],
            element.get('Memory_Clock'),
            'assets/new_images/vga-card.png');
      } else {
        print('not exist');
      }
    });
    catchMemory();
  }

  // get the data of memory
  void catchMemory() async {
    // print('here');
    CollectionReference hardwareref =
        FirebaseFirestore.instance.collection('Memory');
    var quearySnapShot = await hardwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        var randomm = rng.nextDouble();
        if (randomm > .5) {
          rating = rng.nextDouble() + 4;
        } else {
          rating = rng.nextDouble() + 3;
        }
        // print(rating);
        // print(element.data());
        addhardware(
            element.id,
            element.get('Prices') as String,
            element.get('Modules') as String,
            element.get('Name') as String,
            rating,
            [element.get('CAS_latency') as String, 'CAS_l'],
            [element.get('First_word_latency') as String, 'FWL'],
            [element.get('Modules') as String, 'Modules'],
            element.get('First_word_latency'),
            'assets/new_images/ram.png');
      } else {
        print('not exist');
      }
    });
    catchstorage();
  }

  // get the data of storage
  void catchstorage() async {
    CollectionReference hardwareref =
        FirebaseFirestore.instance.collection('Storage');
    var quearySnapShot = await hardwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        var randomm = rng.nextDouble();
        if (randomm > .5) {
          rating = rng.nextDouble() + 4;
        } else {
          rating = rng.nextDouble() + 3;
        }
        // print(element.data());
        addhardware(
            element.id,
            element.get('Price') as String,
            element.get('Form_Factor') as String,
            element.get('Name') as String,
            rating,
            [element.get('Capacity') as String, 'Capacity'],
            [element.get('Type') as String, 'Type'],
            [element.get('Price_Gb') as String, 'Price_Gb'],
            element.get('Interface'),
            'assets/new_images/harddisk.png');
      } else {
        print('not exist');
      }
    });
    catchcooler();
  }

  // get the data of cooler
  void catchcooler() async {
    // print('here');
    CollectionReference hardwareref =
        FirebaseFirestore.instance.collection('CPU Cooler');
    var quearySnapShot = await hardwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        var randomm = rng.nextDouble();
        if (randomm > .5) {
          rating = rng.nextDouble() + 4;
        } else {
          rating = rng.nextDouble() + 3;
        }
        // print(element.data());
        addhardware(
            element.id,
            element.get('Price') as String,
            element.get('Brand') as String,
            element.get('Model') as String,
            rating,
            [element.get('Brand') as String, 'Brand'],
            [element.get('AMD AM4') as String, 'AMD AM4'],
            [element.get('RGB Sync') as String, 'RGB Sync'],
            element.get('LGA 115x, 1200'),
            'assets/new_images/cooler.png');
      } else {
        print('not exist');
      }
    });
    catchMotherBoard();
  }

  void catchMotherBoard() async {
    // print('here');
    CollectionReference hardwareref =
        FirebaseFirestore.instance.collection('Motherboard');
    var quearySnapShot = await hardwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        var randomm = rng.nextDouble();
        if (randomm > .5) {
          rating = rng.nextDouble() + 4;
        } else {
          rating = rng.nextDouble() + 3;
        }
        addhardware(
            element.id,
            element.get('Prices') as String,
            element.get('Form_Factor') as String,
            element.get('Name') as String,
            rating,
            [element.get('Memory_Max') as String, 'Max'],
            [element.get('Memory_Slots') as String, 'Slots'],
            //problem here to get the scoket /cpu data
            [element.get('Socket') as String, 'Socket'],
            element.get('Color'),
            'assets/new_images/motherboard.png');
      } else {
        print('not exist');
      }
    });
    catchcase();
  }

  void catchcase() async {
    // print('here');
    CollectionReference hardwareref =
        FirebaseFirestore.instance.collection('Case');
    var quearySnapShot = await hardwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        var randomm = rng.nextDouble();
        if (randomm > .5) {
          rating = rng.nextDouble() + 4;
        } else {
          rating = rng.nextDouble() + 3;
        }
        // print(element.data());
        addhardware(
            element.id,
            element.get('Price') as String,
            element.get('Type') as String,
            element.get('Name') as String,
            rating,
            [element.get('Type') as String, 'Type'],
            [element.get('Color') as String, 'Color'],
            [element.get('Side Panel Window') as String, 'SPW'],
            element.get('Power Supply'),
            'assets/new_images/computer-tower.png');
      } else {
        print('not exist');
      }
    });
    catchpowerSupply();
  }

  void catchpowerSupply() async {
    // print('here');
    CollectionReference hardwareref =
        FirebaseFirestore.instance.collection('Power Supply');
    var quearySnapShot = await hardwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        var randomm = rng.nextDouble();
        if (randomm > .5) {
          rating = rng.nextDouble() + 4;
        } else {
          rating = rng.nextDouble() + 3;
        }
        // print(element.data());
        addhardware(
            element.id,
            element.get('Price') as String,
            element.get('Form Factor') as String,
            element.get('Name') as String,
            rating,
            [element.get('Wattage') as String, 'Wattage'],
            [element.get('Efficiency Rating') as String, 'ER'],
            //problem here to get the scoket /cpu data
            [element.get('Moduler') as String, 'Moduler'],
            element.get('Color'),
            'assets/new_images/powerSupply.png');
      } else {
        print('not exist');
      }
    });
  }

  Hardware findbyid(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  void addhardware(
      String productId,
      String price,
      String Description,
      String Manfacturer,
      double rating,
      List<String> prop1,
      List<String> prop2,
      List<String> prop3,
      String type,
      String image) {
    _item.add(Hardware(
        id: productId,
        Description: Description,
        color: Colors.blueAccent,
        Manfacturer: type,
        Type: Manfacturer,
        Rating: rating,
        price: price,
        prop1: prop1,
        prop2: prop2,
        prop3: prop3,
        Imageurl: image,
        icon: Icons.computer));

    notifyListeners();
  }


}
