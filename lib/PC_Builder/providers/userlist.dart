import 'package:best_flutter_ui_templates/PC_Builder/providers/user_model.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class userlist with ChangeNotifier {
  List<UserModel> _item = [];

  void catchUser(String uid) async {
    // print('here');
    CollectionReference hardwareref =
        FirebaseFirestore.instance.collection('users');
    var quearySnapShot = await hardwareref.get();

    List<QueryDocumentSnapshot> listdocs = quearySnapShot.docs;
// the code here donot work
    listdocs.forEach((element) {
      // print(element.get('Name'));
      if (element.exists) {
        // print(element.data());
        adduser(
          element.get('firstName') as String,
          element.get('address') as String,
          element.get('age') as String,
          element.get('budget') as String,
          element.get('email') as String,
          element.id,
        );
      } else {
        print('not exist');
      }
    });
  }

  void adduser(
    String name,
    String address,
    String age,
    String budget,
    String email,
    String id,
  ) {
    _item.add(UserModel(
        firstName: name,
        secondName: '',
        age: age,
        email: email,
        address: address,
        budget: budget,
        uid: id));

    notifyListeners();
  }

  List<UserModel> get items {
    return [..._item];
  }
}
