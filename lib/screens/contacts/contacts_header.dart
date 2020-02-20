import 'package:flutter/material.dart';
import 'package:weichat/screens/SearchPage.dart';
import 'package:badges/badges.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weichat/store/newFriend/newFriend.dart';

class ContactHeader extends StatelessWidget {

  Widget newFriendCountWidget() {
    var count = newFriend.newFriendDataCount;
    if(count !=0 && count != null) {
      return Badge(
        badgeContent: Observer(builder: (_) =>Text('${newFriend.newFriendDataCount}', style: TextStyle(color: Colors.white))),
        badgeColor: Colors.red,
        child: new Image.asset('images/addperson.png', width: 30, height: 30),
      );
    } else {
      return new Image.asset('images/addperson.png', width: 30, height: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      new ListTile(
          onTap: () => {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new SearchFriendPage(showNewFriendsList: true)
              )
            )
          },
          leading: Observer(builder: (_) => newFriendCountWidget()),
          title: new Text('新加好友'),
      ),
      new ListTile(
        onTap: () => print('打印发起群聊'),
        leading: new Image.asset('images/group.png', width: 30, height: 30),
        title: new Text('群聊'),
      )
    ]);
  }
}