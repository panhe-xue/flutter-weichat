import 'package:flutter/material.dart';
import 'package:weichat/resources/local_data_provider.dart';

class LoadingPage extends StatefulWidget {
  final bool isLogin = LocalDataProvider.getInstance().isLogin();
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      if(widget.isLogin != null) {
        if(widget.isLogin) {
          return Navigator.of(context).pushReplacementNamed("app");
        } else {
          return Navigator.of(context).pushReplacementNamed("login");
        }
      } else {
        return Navigator.of(context).pushReplacementNamed("login");
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Image.asset('images/loading.jpeg', fit: BoxFit.cover)
        ],
      ),
    );
  }
}