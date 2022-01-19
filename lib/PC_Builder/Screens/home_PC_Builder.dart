import 'package:best_flutter_ui_templates/PC_Builder/providers/Hardware_provider.dart';

import 'package:provider/provider.dart';

import '../items/hardware_homepage_list_view.dart';
import 'Hardware_info_screen.dart';
import 'popular_Models_list_view.dart';

import '../providers/Hardware_provider.dart';
import '../providers/software_provider.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import '../PC_Builder_app_theme.dart';
import '../../custom_drawer/home_drawer.dart';
// import 'package:provider/provider.dart';
// import 'package:best_flutter_ui_templates/PC_Builder/providers/Hardware_provider.dart';

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
      hardwaredata.catchGpu();
      hardwaredata.catchMemory();
      hardwaredata.catchstorage();
      hardwaredata.catchMotherBoard();
      hardwaredata.catchcooler();
      hardwaredata.catchpowerSupply();
      softwaredata.catchApplications();
      hardwaredata.catchcase();
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
                      getSearchBarUI(),
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
        Container(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: TextButton(
              onPressed: () => null,
              child: Text('See More...',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: PCBuilderAppTheme.nearlyBlue,
                  ))),
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
          Container(
            child: TextButton(
              onPressed: () => null,
              child: Text(
                'See More ...',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.27,
                  color: PCBuilderAppTheme.nearlyBlue,
                ),
              ),
            ),
          ),
          Text('Popular Models',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 0.27,
                color: PCBuilderAppTheme.darkerText,
              )),
          Flexible(
            child: PopularModelListView(
              callBack: () {
                moveTo();
              },
            ),
          )
        ],
      ),
    );
  }

  // Widget getButtonUI(bool isSelected) {
  //   String txt = '';

  //   return Expanded(
  //     child: Container(
  //       decoration: BoxDecoration(
  //           color: isSelected
  //               ? PCBuilderAppTheme.nearlyBlue
  //               : PCBuilderAppTheme.nearlyWhite,
  //           borderRadius: const BorderRadius.all(Radius.circular(24.0)),
  //           border: Border.all(color: PCBuilderAppTheme.nearlyBlue)),
  //       child: Material(
  //         color: Colors.transparent,
  //         child: InkWell(
  //           splashColor: Colors.white24,
  //           borderRadius: const BorderRadius.all(Radius.circular(24.0)),
  //           onTap: () {
  //             setState(() {});
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.only(
  //                 top: 12, bottom: 12, left: 18, right: 18),
  //             child: Center(
  //               child: Text(
  //                 txt,
  //                 textAlign: TextAlign.left,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 12,
  //                   letterSpacing: 0.27,
  //                   color: isSelected
  //                       ? PCBuilderAppTheme.nearlyWhite
  //                       : PCBuilderAppTheme.nearlyBlue,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: PCBuilderAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for HW/SW',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
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
