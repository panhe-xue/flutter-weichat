
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './messagePage/message_page.dart';
import './contacts/contacts.dart';
import './MineScreen.dart';
import 'package:badges/badges.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MainPageWidget(),
    );
  }
}

class MainPageWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> {
  final selectionColor=Colors.green;//选中的颜色
  final unSelectionColor=Colors.grey;//未选中的颜色
  int _curIndex = 0;
  List<Widget> widgetList=List();
  @override
  void initState() {
    widgetList..add(HomeScreen())
      ..add(FriendListScreen())
      ..add(MineScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _curIndex,
          onTap: (int index) {
            setState(() {
              _curIndex = index;
            });
          },
          items: <BottomNavigationBarItem> [
            new BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('微信')),
            new BottomNavigationBarItem(icon:Icon(Icons.people), title: Text('通讯录')),
            new BottomNavigationBarItem(icon: Icon(Icons.people_outline), title: Text('我'))
          ]),
      body: widgetList[_curIndex],
    );
  }
}