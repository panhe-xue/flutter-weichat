// 消息类型
import 'dart:convert';
import 'dart:core';
import 'package:weichat/resources/network-provider.dart';
import 'package:weichat/screens/newAddFriend/NewFriendData.dart';

Future loadNewFriendList() async {
  List<NewFriendData> newFriendData = [];
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
    ));
  }
  return newFriendData;
}