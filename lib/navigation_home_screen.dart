import 'package:best_flutter_ui_templates/About_us.dart';
import 'package:best_flutter_ui_templates/PC_Builder/Screens/Hardware_screen.dart';
import 'package:best_flutter_ui_templates/PC_Builder/Screens/ModelScreen.dart';

import './PC_Builder/Screens/Software_Screen.dart';
import 'PC_Builder/Screens/home_PC_Builder.dart';
import 'app_theme.dart';
import './custom_drawer/drawer_user_controller.dart';
import './custom_drawer/home_drawer.dart';
import 'package:best_flutter_ui_templates/feedback_screen.dart';
import 'package:best_flutter_ui_templates/help_screen.dart';
import 'invite_friend_screen.dart';
import 'PC_Builder/Screens/home_PC_Builder.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerName? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerName.HOME;
    screenView = PCBUilderHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: home_drawer(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerName drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerName drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerName.HOME) {
        setState(() {
          screenView = PCBUilderHomeScreen();
        });
      } else if (drawerIndex == DrawerName.Help) {
        setState(() {
          screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerName.FeedBack) {
        setState(() {
          screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerName.Model) {
        setState(() {
          screenView = ModelScreen();
        });
      } else if (drawerIndex == DrawerName.SoftWare) {
        setState(() {
          screenView = Software_scresen();
        });
      } else if (drawerIndex == DrawerName.HardWare) {
        setState(() {
          screenView = HardwareScreen();
        });
      } else if (drawerIndex == DrawerName.Invite) {
        setState(() {
          screenView = InviteFriend();
        });
      } else if (drawerIndex == DrawerName.about_us) {
        setState(() {
          screenView = About_usScreen();
        });
      } else {
        //do in your way......
      }
    }
  }
}
