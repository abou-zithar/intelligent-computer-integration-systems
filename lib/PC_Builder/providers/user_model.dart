import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel with ChangeNotifier {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String budget;
  String? address;
  String? age;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.address,
      this.age,
      this.budget = '10000'});

  // receiving data from server

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      age: map['age'],
      budget: map['budget'],
      address: map['address'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'age': age,
      'address': address,
      'budget': budget,
    };
  }
}
