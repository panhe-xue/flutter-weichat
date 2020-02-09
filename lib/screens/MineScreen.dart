import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weichat/resources/local_data_provider.dart';

class MineScreen extends StatelessWidget {
  final String nickname = LocalDataProvider.getInstance().getNickName();
  final String account = LocalDataProvider.getInstance().getAccount();
  final String avatar = LocalDataProvider.getInstance().getAvatar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFebebeb),
      body: ListView(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          height: 80.0,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 12.0, right: 15.0),
                child: avatar == null ?Image.asset('images/a001.jpg', width: 70.0, height: 70.0) : Image.network(avatar, width: 70.0, height: 70.0)
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      nickname,
                      style: TextStyle(fontSize: 18.0, color: Color(0xFF353535)),
                    ),
                    Text(
                      '账号: $account',
                      style: TextStyle(fontSize: 14.0, color: Color(0xFFa9a9a9)),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12.0, right: 15.0),
                child: Image.asset('images/code.png', width: 24.0, height: 24.0),
              )
            ]
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          color: Colors.white,
          child: ListTile(
            onTap: () => print('好友动态'),
            leading: Image.asset('images/view.png', width: 32.0, height: 32.0),
            title: Text('好友动态'),
            trailing: new Icon(Icons.navigate_next)
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          color: Colors.white,
          child: Column(children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFebebeb)))
              ),
              child: ListTile(
                onTap: () => print('支付'),
                leading: Image.asset('images/pay.png', width: 32.0, height: 32.0),
                title: Text('支付'),
                trailing: new Icon(Icons.navigate_next)
              ),
            ),
            Container(
              decoration: new BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5, color: Color(0xFFebebeb)))
              ),
              child: ListTile(
                onTap: () => print('进行相册'),
                leading: Image.asset('images/photo.png', width: 32.0, height: 32.0),
                title: Text('相册'),
                trailing: new Icon(Icons.navigate_next)
              ),
            ),
            ListTile(
              onTap: () => print('进行表情'),
              leading: Image.asset('images/face.png', width: 32.0, height: 32.0),
              title: Text('表情'),
              trailing: new Icon(Icons.navigate_next)
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          color: Colors.white,
          child: ListTile(
            onTap: () => print('设置'),
            leading: Image.asset('images/setting.png', width: 32.0, height: 32.0),
            title: Text('设置'),
            trailing: new Icon(Icons.navigate_next)
          ),
        ),
      ]),
    );
  }
}