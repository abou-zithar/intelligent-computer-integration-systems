import 'package:best_flutter_ui_templates/PC_Builder/providers/userlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../providers/Models.dart' show Models;
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? users = FirebaseAuth.instance.currentUser;
    String uid;

// Check if the user is signed in
    if (users != null) {
      uid = users.uid; // <-- User ID
      String? email = users.email;

      // <-- Their email
    }

    final user = Provider.of<userlist>(context);
    final modeldata = Provider.of<Models>(context);
    final model = modeldata.items;
    user.catchUser(users!.uid);
    var theuser = user.items;
    if (theuser.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(color: Colors.lightBlue),
                  child: Container(
                    width: double.infinity,
                    height: 350.0,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://zultimate.com/wp-content/uploads/2019/12/default-profile.png",
                            ),
                            radius: 50.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "${theuser[0].firstName}",
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 22.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Model",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "${model.length}",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.lightBlue,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Address",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "${theuser[0].address}",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.lightBlue,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Budget",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "${theuser[0].budget}",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.lightBlue,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Info:",
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontStyle: FontStyle.normal,
                            fontSize: 28.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '\nage:${theuser[0].age} \n\nEmail:${theuser[0].email}',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 300.00,
                child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    elevation: 0.0,
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [Colors.lightBlue, Colors.lightBlueAccent]),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Contact me",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
