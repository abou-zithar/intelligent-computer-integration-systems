import 'package:flutter/widgets.dart';
import '../PC_Builder/Screens/home_PC_Builder.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/PC_Builder/design_course.png',
      navigateScreen: PCBUilderHomeScreen(),
    )
  ];
}
