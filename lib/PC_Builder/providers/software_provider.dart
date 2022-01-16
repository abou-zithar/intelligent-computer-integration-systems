import 'package:flutter/material.dart';
import 'software.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class software with ChangeNotifier {
  List<Software> _softwareitems = [
    // Software(
    //     id: '1S',
    //     title: 'league of legends',
    //     rating: 4.3,
    //     version: ['8'],
    //     color: Colors.purple,
    //     discription: '',
    //     imagePath: 'assets/new_applications/joystick.png',
    //     prop1: 'mid',
    //     prop2: 'Game'),
    // Software(
    //     id: '2S',
    //     title: 'facebook',
    //     rating: 4.9,
    //     version: ['1.4'],
    //     color: Colors.blueAccent,
    //     discription: 'very good software',
    //     imagePath: 'assets/new_applications/facebook.png',
    //     prop1: 'low',
    //     prop2: 'app'),
    // Software(
    //     id: '3S',
    //     title: 'apex',
    //     rating: 4.0,
    //     version: ['5'],
    //     color: Colors.red,
    //     discription: '',
    //     imagePath: 'assets/new_applications/joystick.png',
    //     prop1: 'High',
    //     prop2: 'Game'),
    // Software(
    //     id: '4S',
    //     title: 'discord',
    //     rating: 4.5,
    //     version: ['3', '7'],
    //     color: Colors.teal,
    //     discription: '',
    //     imagePath: 'assets/new_applications/discord.png',
    //     prop1: 'low',
    //     prop2: 'app'),
    // Software(
    //     id: '5S',
    //     title: 'photoshop',
    //     rating: 4.3,
    //     version: ['7'],
    //     color: Colors.blue,
    //     discription: '',
    //     imagePath: 'assets/new_applications/adobe-photoshop.png',
    //     prop1: 'high',
    //     prop2: 'app'),
    // Software(
    //     id: '6S',
    //     title: 'instagram',
    //     rating: 4.3,
    //     version: ['8'],
    //     color: Colors.greenAccent,
    //     discription: '',
    //     imagePath: 'assets/new_applications/instagram.png',
    //     prop1: 'low',
    //     prop2: 'app'),
    // Software(
    //     id: '7S',
    //     title: 'todo',
    //     rating: 4.3,
    //     version: ['1.3'],
    //     color: Colors.white24,
    //     discription: '',
    //     imagePath: 'assets/new_applications/to-do-list.png',
    //     prop1: 'low',
    //     prop2: 'app'),
    // Software(
    //     id: '8S',
    //     title: 'VLC',
    //     rating: 4.3,
    //     version: ['8.6'],
    //     color: Colors.orange,
    //     discription: '',
    //     imagePath: 'assets/new_applications/vlc-player.png',
    //     prop1: 'low',
    //     prop2: 'app'),
    // Software(
    //     id: '9S',
    //     title: 'What\'sapp',
    //     rating: 4.3,
    //     version: ['9.5'],
    //     color: Colors.lightGreen,
    //     discription: '',
    //     imagePath: 'assets/new_applications/whatsapp.png',
    //     prop1: 'low',
    //     prop2: 'app'),
    // Software(
    //     id: '10S',
    //     title: 'Cities skylines',
    //     rating: 4.3,
    //     version: ['1'],
    //     color: Colors.white12,
    //     discription: '',
    //     imagePath: 'assets/new_applications/joystick.png',
    //     prop1: 'Away high',
    //     prop2: 'Game'),
  ];
  var rng = new Random();
  var rating;
  var _showFavoritesOnly = false;
  void catchApplications() async {
    // print('here');
    CollectionReference softwareref =
        FirebaseFirestore.instance.collection('Applications');
    var quearySnapShot = await softwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        rating = rng.nextDouble() * 5;
        // print(element.data());
        addsoftware(
          element.id,
          element.get('Name') as String,
          element.get('Image_URL') as String,
          element.get('Overhead') as String,
          rating,
          [element.get('Type') as String, 'Type'],
          element.get('Versions'),
        );
      } else {
        print('not exist');
      }
    });
  }

  List<Software> get items {
    if (_showFavoritesOnly) {
      return _softwareitems.where((element) => element.isFavorite).toList();
    }
    return [..._softwareitems];
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  Software findbyid(String id) {
    return _softwareitems.firstWhere((element) => element.id.toString() == id);
  }

  void addsoftware(
      String productId,
      String title,
      String imagepath,
      String overhead,
      double rating,
      List<String> prop1,
      List<String> version) {
    _softwareitems.add(Software(
      id: productId,
      title: title,
      imagePath: imagepath,
      prop1: prop1,
      version: version,
    ));

    notifyListeners();
  }
}
