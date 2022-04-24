import 'package:flutter/material.dart';
import 'software.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class software with ChangeNotifier {
  List<Software> _softwareitems = [];
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
        var randomm = rng.nextDouble();
        if (randomm > .5) {
          rating = rng.nextDouble() + 4;
        } else {
          rating = rng.nextDouble() + 3;
        }

        // print(rating);
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

  void addsoftware(String productId, String title, String imagepath,
      String overhead, double rating, List<String> prop1, String version) {
    _softwareitems.add(Software(
      id: productId,
      title: title,
      discription: overhead,
      rating: rating,
      imagePath: imagepath,
      prop1: prop1,
      version: version,
    ));

    notifyListeners();
  }
}
