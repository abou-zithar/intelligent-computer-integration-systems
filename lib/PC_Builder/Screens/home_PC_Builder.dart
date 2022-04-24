import 'package:best_flutter_ui_templates/PC_Builder/Items/Searchbar.dart';
import 'package:best_flutter_ui_templates/PC_Builder/Items/software_homePage_list_view%20copy.dart';
import 'package:best_flutter_ui_templates/PC_Builder/Screens/Software_info_screen.dart';
import 'package:best_flutter_ui_templates/PC_Builder/providers/Hardware_provider.dart';

import 'package:provider/provider.dart';

import '../items/hardware_homepage_list_view.dart';
import 'Hardware_info_screen.dart';
import 'popular_Models_list_view.dart';

import '../providers/Hardware_provider.dart';
import '../providers/software_provider.dart';

import 'package:flutter/material.dart';
import '../PC_Builder_app_theme.dart';
import '../../custom_drawer/home_drawer.dart';

class PCBUilderHomeScreen extends StatefulWidget {
  @override
  _PCBUilderHomeScreenState createState() => _PCBUilderHomeScreenState();
}

class _PCBUilderHomeScreenState extends State<PCBUilderHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final hardwaredata = Provider.of<hardware>(context, listen: false);
    final softwaredata = Provider.of<software>(context, listen: false);

    void getdataFrombackend() {
      hardwaredata.catchcpu();
      softwaredata.catchApplications();
    }

    getdataFrombackend();

    return Container(
      color: PCBuilderAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(context),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      SearchBar(),
                      getHardwareUI(),
                      Flexible(
                        child: getPopularModelsUI(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHardwareUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'popular Hardware',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: PCBuilderAppTheme.darkerText,
            ),
          ),
        ),
        HardwareListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  void moveTo() {
    Navigator.pushNamed(
      context,
      HardwareInfoScreen.routName,
    );
  }

  Widget getPopularModelsUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Popular software',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 0.27,
                color: PCBuilderAppTheme.darkerText,
              )),
          Flexible(child: SoftwareListView(
            callBack: () {
              moveTosw();
            },
          ))
        ],
      ),
    );
  }

  void moveTosw() {
    Navigator.pushNamed(
      context,
      SoftwareInfoScreen.routName,
    );
  }

  Widget getAppBarUI(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Get your',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: PCBuilderAppTheme.grey,
                  ),
                ),
                Text(
                  'Dreams PC',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: PCBuilderAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: TextButton(
                onPressed: () => HomeDrawer.selectAccount(ctx),
                child: Image.asset('assets/fitness_app/tab_4.png')),
          )
        ],
      ),
    );
  }
}
