import 'package:flutter/material.dart';
import 'package:weichat/resources/network-provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weichat/store/newFriend/status.dart';
import 'dart:convert';
import 'package:weichat/utils/ui_util.dart';
import 'package:weichat/store/newFriend/contact.dart';
import 'package:weichat/screens/contacts/contact_vo.dart';
import 'package:weichat/screens/newAddFriend/NewFriendData.dart';

class NewFriendItem extends StatelessWidget {
  NewFriendData data;
  NewFriendItem(this.data);
  Status _status = new Status();

  Widget _getFriendStatus () {
    if(_status.status == 0) {
      return RaisedButton(
        child: Text('添加', style: TextStyle(color: Colors.blue.shade300)),
        onPressed: () async {
          print('ppppppppppooooooooo');
          print(data.uid);
          print(data.avatar);
          var res = await NetworkProvider().addFriend({
            'uid': data.uid
          });
          var result = json.decode(res);
          if(result['ret'] == 0) {
            var res = await loadContacts();
            contact.set(res);
            _status.set(1);
            UiUtil.showToast('添加成功');
          }
        },
      );
    } else if(_status.status == 1) {
      return Text('已添加', style: TextStyle(color: Colors.blue.shade300));
    } else {
      return Text('已拒绝', style: TextStyle(color: Colors.blue.shade300));
    }
  }
  @override
  Widget build(BuildContext context) {
    _status.set(data.status);
    return Container(
      child: new ListTile(
        leading: new Image.network(this.data.avatar, width: 40.0, height: 40.0),
        title: new Text(this.data.nickname),
        subtitle: new Text("请求添加你为朋友"),
        trailing: Observer(builder: (_) => _getFriendStatus())
      ),
      color: Colors.white,
    );
  }
}