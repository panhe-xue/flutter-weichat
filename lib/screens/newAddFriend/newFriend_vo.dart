// 消息类型
import 'dart:convert';
import 'dart:core';
import 'package:weichat/resources/network-provider.dart';

class NewFriendData {
  int uid;
  String avatar;
  String nickname;
  int status; // 0 没有处理 // 1接受 // 3拒绝
  int hasLook; // 0 没有看过 // 2看过
  NewFriendData(this.uid, this.avatar, this.nickname, this.status, this.hasLook);
}

List<NewFriendData> newFriendData = [];

Future loadNewFriendList() async {
  var res = await NetworkProvider().getNewFriendList();
  var data = json.decode(res);
  var result = data["data"];

  newFriendData.clear();
  for(var i=0; i<result.length; i++) {
    var item = result[i];
    newFriendData.add(NewFriendData(
      item['uid'],
      item['avatar'],
      item['nickname'],
      item['status'],
      0,
    ));
  }
  return newFriendData;
}