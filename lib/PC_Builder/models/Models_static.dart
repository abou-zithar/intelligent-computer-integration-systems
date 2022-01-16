import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Models {
  Models(
      {this.title = '',
      this.imagePath = '',
      this.price = 0,
      this.discription = '',
      this.rating = 0.0,
      this.color = Colors.black});

  String title;
  int price;
  String discription;
  double rating;
  String imagePath;
  Color color;

  
  static List<Models> popularmodelList = <Models>[
    Models(
        imagePath: 'assets/new_images/computer.png',
        title: 'model 1',
        price: 12000,
        discription: 'best model ever',
        rating: 4.8,
        color: Colors.blue),
    Models(
        imagePath: 'assets/new_images/computer.png',
        title: 'model 2',
        price: 28000,
        discription: 'best model ever',
        rating: 4.9,
        color: Colors.blueAccent),
    Models(
        imagePath: 'assets/new_images/computer.png',
        title: 'model 3',
        price: 12000,
        discription: 'best model ever',
        rating: 4.8,
        color: Colors.blue),
    Models(
        imagePath: 'assets/new_images/computer.png',
        title: 'model 4',
        price: 28000,
        discription: 'best model ever',
        rating: 4.9,
        color: Colors.blueAccent),
  ];
}
