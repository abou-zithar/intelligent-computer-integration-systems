import 'dart:io';
import 'package:best_flutter_ui_templates/PC_Builder/Screens/ModelScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'PC_Builder/Screens/Software_info_screen.dart';
import 'app_theme.dart';

import 'PC_Builder/providers/Models.dart';
import 'PC_Builder/providers/software_provider.dart';
import 'navigation_home_screen.dart';
import 'PC_Builder/Screens/Hardware_info_screen.dart';
import 'PC_Builder/providers/Hardware_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'PC_Builder/Screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            //automaticaly remove the provider when you donot need to worry about it
            value: hardware()),
        ChangeNotifierProvider.value(
            //automaticaly remove the provider when you donot need to worry about it
            value: Models()),
        ChangeNotifierProvider.value(
            //automaticaly remove the provider when you donot need to worry about it
            value: software()),
      ],
      child: MaterialApp(
        title: 'Flutter UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        home: LoginScreen(),
        routes: {
          HardwareInfoScreen.routName: (context) => HardwareInfoScreen(),
          ModelScreen.routeName: (context) => ModelScreen(),
          SoftwareInfoScreen.routName: (context) => SoftwareInfoScreen(),
        },
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
