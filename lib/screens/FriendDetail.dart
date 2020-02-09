import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weichat/resources/io-client.dart';
import 'package:weichat/utils/ui_util.dart';
import 'package:weichat/screens/Chat/Chat.dart';

class FriendDetail extends StatelessWidget {
  final String nickname, account, avatar, socketId;
  final bool isFriends;
  final int gender, sender, receicer;
  FriendDetail({Key key,
    @required this.sender,
    @required this.receicer,
    @required this.nickname,
    @required this.account,
    @required this.avatar,
    @required this.gender,
    @required this.socketId,
    @required this.isFriends
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
      ),
      backgroundColor: Color(0xFFebebeb),
      body: ListView(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.5, color: Colors.grey.shade100)),
            color: Colors.white,
          ),
          height: 100.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 12.0, right: 15.0),
                child: avatar == null ? Image.asset('images/a001.jpg', width: 80.0, height: 80.0) : Image.network(avatar, width: 70.0, height: 70.0)
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: <Widget>[
                          Text(
                            nickname,
                            style: TextStyle(fontSize: 22.0, color: Color(0xFF353535)),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(top: 10, left: 5),
                            child: Text(
                              '女',
                              style: TextStyle(fontSize: 12.0, color: Color(0xFF353535)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        '账号: $account',
                        style: TextStyle(fontSize: 14.0, color: Color(0xFFa9a9a9)),
                      ),
                    )
                  ],
                ),
              ),
            ]
          ),
        ),
        Container(
          color: Colors.white,
          child: ListTile(
            onTap: () => print('好友动态'),
            title: Text('设置备注和权限', style: TextStyle(fontSize: 15),),
            trailing: new Icon(Icons.navigate_next)
          ),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.centerLeft,
          height: 60,
          padding: EdgeInsets.only(left: 20),
          margin: const EdgeInsets.only(bottom: 10.0, top: 10),
          child: Row(children: <Widget>[
            Text('来源', style: TextStyle(fontSize: 15)),
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Text('来自手机号搜索', style: TextStyle(color: Colors.grey.shade400, fontSize: 15)),
            )
          ],)
        ),
        GestureDetector(
          onTap: () {
            print('添加好友');
          },
          child: Column(children: <Widget>[
            Offstage(
              offstage: isFriends,
              child: GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  height: 60,
                  color: Colors.white,
                  child: Center(child: Text('添加到通讯录', style: TextStyle(color: Colors.blue.shade900, fontSize: 18)))
                ),
                onTap: () {
                  // 发送好友请求
                  IOClient.getInstance().emit('addFriend', {
                    'target': socketId,
                    'payload': {
                      'sender' : sender,
                      'receiver' : receicer,
                      'nickname' : nickname,
                      'avatar' : avatar
                    },
                  });
                  UiUtil.showToast('添加好友成功');
                })
            ),
            Offstage(
              offstage: !isFriends,
              child: GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  height: 60,
                  color: Colors.white,
                  child: Center(child: Text('发送消息', style: TextStyle(color: Colors.blue.shade900, fontSize: 18)))
                ),
                onTap: () {
                  // 发送消息
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new Chat()));
                })
            ),
          ]),
        ),
      ]),
    );
  }
}