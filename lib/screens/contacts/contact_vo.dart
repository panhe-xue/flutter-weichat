import 'package:weichat/resources/network-provider.dart';
import 'dart:convert';
import 'dart:core';
import 'package:lpinyin/lpinyin.dart';
class ContactData {
  int uid;
  String avatar;
  String nickname;
  String phone;
  var gender;
  String socketId;
  String sessionKey;
  ContactData(this.uid, this.avatar, this.nickname, this.phone, this.gender, this.socketId, this.sessionKey);
}

List<ContactData> contactsData = [];

Future loadContacts() async {
  var res = await NetworkProvider().getRelationship();
  var data = json.decode(res);
  var result = data["data"];
  contactsData.clear();
  contactsData.add(
    ContactData(
      1,
      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1580378332220&di=4c466a50955148dd597a59a89ea74880&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201809%2F21%2F20180921195352_lmgic.jpg',
      'a机器人',
      '15827783703',
      0,
      '',
      'A'
    )
  );
  for(var i=0; i<result.length; i++) {
    var item = result[i];
    var capital = PinyinHelper.getFirstWordPinyin(item['nickname']);
    contactsData.add(ContactData(
      item['id'],
      item['avatar'],
      item['nickname'],
      item['phone'],
      item['gender'],
      item['socketId'],
      capital.toUpperCase()[0]
    ));
  }
  return contactsData;
}