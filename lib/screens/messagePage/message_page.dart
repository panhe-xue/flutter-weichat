import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './message_item.dart';
import 'package:weichat/screens/SearchPage.dart';
import 'package:weichat/store/message/message.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title:  Text("好友"),
        centerTitle: false,
        actions: <Widget>[
          Listener(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Icon(Icons.search)
            ),
            onPointerDown: (PointerDownEvent event) => print('点击搜索'),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: PopupMenuButton(
                color: Colors.black87,
                onSelected: (String value) {
                  switch (value) {
                    case 'allChat':
                      print('allChat');
                    break;
                    case 'addFriend':
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new SearchFriendPage(showNewFriendsList: false)
                        )
                      );
                    break;
                    case 'ss':
                      print('ss');
                    break;
                    case 'sf':
                      print('sf');
                    break;
                    case 'help':
                      print('help');
                    break;
                  }
                },
                child: Icon(Icons.add_circle_outline),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem <String>>[
                    PopupMenuItem<String>(child: new ListTile(leading: new Icon(Icons.message, color: Colors.white,), title: new Text("发起群聊", style: TextStyle(color: Colors.white),)), value: 'allChat'),
                    PopupMenuItem<String>(child: new ListTile(leading: new Icon(Icons.group_add, color: Colors.white), title: new Text("添加朋友", style: TextStyle(color: Colors.white))), value: 'addFriend'),
                    PopupMenuItem<String>(child: new ListTile(leading: new Icon(Icons.cast_connected, color: Colors.white), title: new Text("扫一扫", style: TextStyle(color: Colors.white))), value: 'ss'),
                    PopupMenuItem<String>(child: new ListTile(leading: new Icon(Icons.money_off, color: Colors.white), title: new Text("收付款", style: TextStyle(color: Colors.white))), value: 'sf'),
                    PopupMenuItem<String>(child: new ListTile(leading: new Icon(Icons.email, color: Colors.white), title: new Text("帮助反馈", style: TextStyle(color: Colors.white))), value: 'help'),
                  ];
                },
              )
          )
        ],
      ),
      body: Center(
        child: Observer(builder: (_) => ListView.builder(
          itemCount: message.messageList.length,
          // reverse: true,
          itemBuilder: (BuildContext context, int index) {
            return Observer(builder: (_) => MessageItem(message.messageList[index], index));
          },
        ))
      ),
    );
  }
}