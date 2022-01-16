import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../../navigation_home_screen.dart';

// Create a Form widget.
class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() {
    return SettingScreenState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class SettingScreenState extends State<SettingScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  // the controllers of the form
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final budgetController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    ageController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    budgetController.dispose();

    super.dispose();
  }

  UpdateDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = nameController.text;

    userModel.budget = budgetController.text;
    userModel.address = addressController.text;
    userModel.age = ageController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .update(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Edited successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => NavigationHomeScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          actions: [],
          title: Text('Setting'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                      controller: nameController,
                      onChanged: (text) {},
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length > 20) {
                          return 'Please enter Shorter userName';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Username',
                      )),

                  SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                      controller: ageController,
                      onChanged: (text) {},
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some Numbers';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Age',
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: addressController,
                      onChanged: (text) {},
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Address',
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: budgetController,
                      onChanged: (text) {},

                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (false) {
                          return 'Please enter higher value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Budget',
                      )),

                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                      controller: passwordController,
                      onChanged: (text) {},
                      // The validator receives the text that the user has entered.
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Password',
                      )),

                  new FlutterPwValidator(
                      controller: passwordController,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      numericCharCount: 2,
                      width: 400,
                      height: 150,
                      onSuccess: () {}),

                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                      controller: confirmpasswordController,
                      onChanged: (text) {},
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value != passwordController.text) {
                          return ' the password don\'t match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      UpdateDetailsToFirestore();
                      showDialog(
                        context: context,
                        builder: (context) {
                          // Retrieve the text that the user has entered by using the
                          // TextEditingController.

                          return SizedBox.shrink();
                        },
                      );
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data Updated')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  // Add TextFormFields and ElevatedButton here.
                ],
              ),
            ),
          ),
        ));
  }
}
