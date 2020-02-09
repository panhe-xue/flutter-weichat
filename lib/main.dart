import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import './screens/LoginPage.dart';
import './screens/MainPage.dart';
import './screens/RegisterPage.dart';
import 'package:weichat/resources/local_data_provider.dart';
import 'package:weichat/screens/LoadingPage.dart';

saveSystemInfo() async {
  await LocalDataProvider.getInstance().initData();
  if (Platform.isIOS) {
    LocalDataProvider.getInstance().setIos();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await saveSystemInfo();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      routes: <String, WidgetBuilder> {
        "app": (BuildContext context) => MainPage(),
        "login": (BuildContext context) => LoginPage(),
        "register": (BuildContext context) => RegisterPage(),
        // "search": (BuildContext context) => Search()
      },
      home: LoadingPage()
    );
  }
}

