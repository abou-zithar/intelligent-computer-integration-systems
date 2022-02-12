import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class About_usScreen extends StatefulWidget {
  @override
  _About_usScreenState createState() => _About_usScreenState();
}
// ignore: camel_case_types
class _About_usScreenState extends State<About_usScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 100,
                        left: 16,
                        right: 16),
                    child: Image.asset('assets/new_images/OIP.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'we are hoping to make the process of chooseing pcs and building it much easier and to create a simple recommendation system that will help you and help every one to build a pc that fit his budget and fit his requirements to make the user get the maximum profit from there pcs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
