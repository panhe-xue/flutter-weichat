import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("发现"),
        centerTitle: false,
        // backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Text('发现页面'),
      ),
    );
  }
}