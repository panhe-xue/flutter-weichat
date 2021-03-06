import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:weichat/resources/network-provider.dart';
import 'package:dio/dio.dart';
import 'package:weichat/utils/ui_util.dart';
import 'package:weichat/resources/local_data_provider.dart';
import 'package:weichat/resources/io-client.dart';

class RegisterModel {
  String nickname;
  String email;
  String phone;
  String avatar;
  String password;
  String repassword;
  Map toJson() {
    Map map = new Map();
    map['nickname']   = this.nickname;
    map['email']      = this.email;
    map['phone']      = this.phone;
    map['avatar']     = this.avatar;
    map['password']   = this.password;
    map['repassword'] = this.repassword;
    return map;
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  RegisterModel _registerData = RegisterModel();

  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();

  // 上传文件
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadImage(image);
    setState(() {
      _image = image;
    });
  }

  //上传图片到服务器
  _uploadImage(File image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = new FormData.fromMap({
      'file': await MultipartFile.fromFile(path, filename: name),
    });
    var response = await NetworkProvider().uploadImage(formData);
    var data = json.decode(response);
    // print('上传图片返回$data');
    if (data['ret'] == 0) {
      _registerData.avatar = data['avatar'];
    } else {
      UiUtil.showToast('上传文件失败');
    }
  }
  // 登录
  void register() async {
    var loginForm = loginKey.currentState;
    loginForm.save();
    if(loginForm.validate()) {
      // 发送请求register
      var res = await NetworkProvider().register(jsonEncode(_registerData));

      var data = json.decode(res);
      var status = data['ret'];
      if(status == 0) {
        LocalDataProvider.getInstance().setToken(data['token']);
        LocalDataProvider.getInstance().saveUserInfo(data['userInfo']);
        IOClient.getInstance(data['id']);
        Navigator.of(context).pushReplacementNamed("app");
      } else {
        showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
              return AlertDialog(
                title: Text('提示'),
                content: Text(data["msg"]),
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

    Widget inputTextArea =new Container(
      padding: const EdgeInsets.all(16.0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white
      ),
      child: new Form(
        key: loginKey,
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Expanded(
                flex: 4,
                child: TextFormField(
                  decoration: InputDecoration(labelText: '请输入昵称'),
                  validator: (value) {
                    return value.length == 0 ? '请输入昵称' : null;
                  },
                  onSaved: (value) {
                    _registerData.nickname = value;
                  },
                ),
              ),
              new Expanded(
                flex: 1,
                child: _image == null ?
                RaisedButton(
                  child: Image.asset('images/upload.png'),
                  onPressed: () {
                    getImage();
                  },
                ) : RaisedButton(
                  child: Image.file(_image),
                  onPressed: () {
                    getImage();
                  },
                ),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '请输入email'),
            validator: (value) {
              return value.length == 0 ? '请输入email' : null;
            },
            onSaved: (value) {
              _registerData.email = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '请输入手机号'),
            validator: (value) {
              return value.length == 0 ? '请输入手机号' : null;
            },
            onSaved: (value) {
              _registerData.phone = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '请输入密码'),
            obscureText: true,
            onSaved: (value) {
              _registerData.password = value;
            },
            validator: (value) {
              return value.length < 6 ? '密码长度不够6位' : null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: '确认密码'),
            obscureText: true,
            onSaved: (value) {
              // repassword = value;
            },
            validator: (value) {
              return value != _registerData.password ? '两次输入不一致' : null;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: SizedBox(
            width: 340,
            height: 42,
            child: RaisedButton(
              onPressed: register,
              color: Colors.blue,
              child: Text('注册', style: TextStyle(fontSize: 18.0),),
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
              "已有账号?去登录",
              style: TextStyle(
                color: Colors.blue[400],
                fontSize: 16.0,
              ),
            ),
            //忘记密码按钮，点击执行事件
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('login');
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
          inputTextArea,
          new SizedBox(height: 80,),
          bottomArea
        ],
        ),
      ),
    );
  }
}