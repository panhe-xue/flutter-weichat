import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weichat/resources/network-provider.dart';
import 'package:weichat/resources/local_data_provider.dart';
import 'package:weichat/resources/io-client.dart';
import 'package:weichat/store/newFriend/contact.dart';
import 'package:weichat/screens/contacts/contact_vo.dart';
import 'package:weichat/screens/newAddFriend/newFriend_vo.dart';
import 'package:weichat/store/newFriend/newFriend.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  String userName;
  String password;

  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();
  loadStore() async {
    // 设置聊天 store
    // var msg = await loadMessage();
    // message.set(msg);
    // 设置联系人 store
    var con = await loadContacts();
    contact.set(con);
    // 设置new好友历史
    var fri = await loadNewFriendList();
    newFriend.set(fri);
  }
  // 登录
  void login() async {
    var loginForm = loginKey.currentState;
    loginForm.save();
    if(loginForm.validate()) {
      // 发送请求login
      var res = await NetworkProvider().login({
        'nickname': userName,
        'password': password,
      });

      var data = json.decode(res);
      var status = data['ret'];
      if(status == 0) {
        LocalDataProvider.getInstance().setToken(data['token']);
        LocalDataProvider.getInstance().saveUserInfo(data['userInfo']);
        // login socket
        IOClient.getInstance(data['userInfo']['id']);
        await loadStore();
        Navigator.of(context).pushReplacementNamed("app");
      } else {
        // UiUtil.showToast("手机号或者密码错误");
        showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
              return AlertDialog(
                title: Text('提示'),
                content: Text('手机号或者密码不对，请重新输入'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('确定'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
          },
        ).then((val) {
          print(val);
        });
      }

    }
  }
  @override
  Widget build(BuildContext context) {

    Widget logoImageArea = new Container(
      alignment: Alignment.topCenter,
      child: ClipOval(child: Image.asset('images/img.jpg', width: 100, height: 100, fit: BoxFit.cover,)),
    );

    Widget inputTextArea =new Container(
      padding: const EdgeInsets.all(16.0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white
      ),
      child: new Form(
        key: loginKey,
        child: Column(children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: '请输入手机号'),
            validator: (value) {
              return value.length == 0 ? '请输入手机号' : null;
            },
            onSaved: (value) {
              userName = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '请输入密码'),
            obscureText: true,
            onSaved: (value) {
              password = value;
            },
            validator: (value) {
              return value.length < 6 ? '密码长度不够6位' : null;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: SizedBox(
            width: 340,
            height: 42,
            child: RaisedButton(
              onPressed: login,
              child: Text('登录', style: TextStyle(fontSize: 18.0),),
            ),
          ))
        ]),
      ),
    );

    Widget bottomArea = new Container(
      margin: EdgeInsets.only(right: 20,left: 30),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            child: Text(
              "忘记密码?",
              style: TextStyle(
                color: Colors.blue[400],
                fontSize: 16.0,
              ),
            ),
            //忘记密码按钮，点击执行事件
            onPressed: (){

            },
          ),
          FlatButton(
            child: Text(
              "快速注册",
              style: TextStyle(
                color: Colors.blue[400],
                fontSize: 16.0,
              ),
            ),
            //点击快速注册、执行事件
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('register');
            },
          )
        ],
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      // 外层添加一个手势，用于点击空白部分，回收键盘
      body: new GestureDetector(
        onTap: (){
          // 点击空白区域，回收键盘
          print("点击了空白区域");
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
        },
        child: new ListView(
          children: <Widget>[
          new SizedBox(height: 80,),
          logoImageArea,
          new SizedBox(height: 80,),
          inputTextArea,
          new SizedBox(height: 80,),
          bottomArea
        ],
        ),
      ),
    );
  }
}