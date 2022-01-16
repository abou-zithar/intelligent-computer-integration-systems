import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/material.dart';

import 'Hardware.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class hardware with ChangeNotifier {
  List<Hardware> _item = [
    // Hardware(
    //     id: '1H',
    //     Rating: 4.3,
    //     Description: 'it is a good CPU',
    //     color: Colors.blueAccent,
    //     Manfacturer: 'inetl',
    //     Type: 'CPU',
    //     price: '15023',
    //     Imageurl: 'assets/new_images/chip.png',
    //     icon: Icons.computer),
    // Hardware(
    //     id: '2H',
    //     Rating: 4.3,
    //     Description: 'it is a good GPU',
    //     color: Colors.blueAccent,
    //     Manfacturer: 'amd',
    //     Type: 'GPU',
    //     price: 13342,
    //     Imageurl: 'assets/new_images/vga-card.png',
    //     icon: Icons.computer),
    // Hardware(
    //     id: '3H',
    //     Rating: 4.3,
    //     Description: 'it is a good storage',
    //     color: Colors.blueAccent,
    //     Manfacturer: 'segate ',
    //     Type: 'storage',
    //     price: 12345,
    //     Imageurl: 'assets/new_images/harddisk.png',
    //     icon: Icons.computer),
    // Hardware(
    //     id: '4H',
    //     Rating: 4.3,
    //     Description: 'it is a good RAM',
    //     color: Colors.blueAccent,
    //     Manfacturer: 'Lenovo ',
    //     Type: 'RAM',
    //     price: 3422,
    //     Imageurl: 'assets/new_images/ram.png',
    //     icon: Icons.computer),
    // Hardware(
    //     id: '5H',
    //     Rating: 4.3,
    //     Description: 'it is a good Cooler',
    //     color: Colors.blueAccent,
    //     Manfacturer: 'IBM',
    //     Type: 'Cooler',
    //     price: 7562,
    //     Imageurl: 'assets/new_images/cooler.png',
    //     icon: Icons.computer),
    // Hardware(
    //     id: '6H',
    //     Rating: 4.3,
    //     Description: 'it\'s a good MotherB',
    //     color: Colors.blueAccent,
    //     Manfacturer: 'LG ',
    //     Type: 'MotherBoard',
    //     price: 14532,
    //     Imageurl: 'assets/new_images/motherboard.png',
    //     icon: Icons.computer),
    // Hardware(
    //     id: '7H',
    //     Rating: 4.3,
    //     Description: 'it is a good case',
    //     color: Colors.blueAccent,
    //     Manfacturer: 'HP',
    //     Type: 'case',
    //     price: 23423,
    //     Imageurl: 'assets/new_images/computer-tower.png',
    //     icon: Icons.computer),
  ];

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
            [element.get('Socket') as String, 'Socket'],
            [element.get('TDP') as String, 'TDP'],
            [element.get('Cores') as String, 'Cores'],
            element.get('Clock'),
            'assets/new_images/chip.png');
      } else {
        print('not exist');
      }
    });
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
        rating = rng.nextDouble() * 5;
        // print(element.data());
        addhardware(
            element.id,
            element.get('Price') as String,
            element.get('Released') as String,
            element.get('Product_Name') as String,
            rating,
            [element.get('GPU_Chip') as String, 'GPU_Chip'],
            [element.get('GPU_Clock') as String, 'GPU_Clock'],
            [element.get('Memory') as String, 'Memory'],
            element.get('Memory_Clock'),
            'assets/new_images/vga-card.png');
      } else {
        print('not exist');
      }
    });
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
        print('object');
        rating = rng.nextDouble() * 5;
        // print(rating);
        // print(element.data());
        addhardware(
            element.id,
            element.get('Prices') as String,
            element.get('Modules') as String,
            element.get('Name') as String,
            rating,
            [element.get('Color') as String, 'Color'],
            [element.get('Speed') as String, 'Speed'],
            [element.get('CAS_latency') as String, 'CAS_latency'],
            element.get('First_word_latency'),
            'assets/new_images/ram.png');
      } else {
        print('not exist');
      }
    });
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
        rating = rng.nextDouble() * 5;
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
        rating = rng.nextDouble() * 5;
        // print(element.data());
        addhardware(
            element.id,
            element.get('Price') as String,
            element.get('Brand') as String,
            element.get('Model') as String,
            rating,
            [element.get('RGB Sync') as String, 'Color'],
            [element.get('AMD AM4') as String, 'AMD AM4'],
            [element.get('Brand') as String, 'Brand'],
            element.get('LGA 115x, 1200'),
            'assets/new_images/cooler.png');
      } else {
        print('not exist');
      }
    });
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
        rating = rng.nextDouble() * 5;
        // print(element.data());
        addhardware(
            element.id,
            element.get('Prices') as String,
            element.get('Memory_Slots') as String,
            element.get('Name') as String,
            rating,
            [element.get('Color') as String, 'Color'],
            [element.get('Form_Factor') as String, 'Form'],
            //problem here to get the scoket /cpu data
            [element.get('Form_Factor') as String, 'Socket'],
            element.get('Memory_Max'),
            'assets/new_images/motherboard.png');
      } else {
        print('not exist');
      }
    });
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
        rating = rng.nextDouble() * 5;
        // print(element.data());
        addhardware(
            element.id,
            element.get('Price') as String,
            element.get('Wattage') as String,
            element.get('Name') as String,
            rating,
            [element.get('Efficiency Rating') as String, 'ER'],
            [element.get('Form Factor') as String, 'Form'],
            //problem here to get the scoket /cpu data
            [element.get('Color') as String, 'Color'],
            element.get('Moduler'),
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

  // bool _disposed = false;

  // @override
  // void dispose() {
  //   _disposed = true;
  //   super.dispose();
  // }

  // @override
  // void notifyListeners() {
  //   if (!_disposed) {
  //     super.notifyListeners();
  //   }
  // }
}
