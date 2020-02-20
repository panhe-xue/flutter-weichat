import 'package:mobx/mobx.dart';

/// 必须, 用于生成.g文件
part 'contact.g.dart';
class Contact = ContactMobx with _$Contact;

abstract class ContactMobx with Store {
  /// 可观察的值
  @observable
  List contactsData = [];

  // 设置值
  @action
  void set(var value) {
    contactsData = value;
  }
  // 往第一插入
  @action
  void setFirst(var value) {
    int index = 0;
    contactsData.insert(index, value);
  }
  //根据uid判断聊天列表是否有此人
  @action
  isInMessageList(uid) {
    int index = contactsData.indexWhere((item) => (item.uid == uid));
    return index;
  }
  // 待开发功能，更新uid对应的socketId
  // ----------改变socketId-----------
  @action
  changeNewsocketId(data) {
    int uid = data['uid'];
    String socketId = data['socketId'];
    // 改变
    int index = isInMessageList(uid);
    if(index != -1) {
      var cur = contactsData;
      cur[index].socketId = socketId;
      contactsData = cur;
    }
  }
}
final Contact contact = Contact();