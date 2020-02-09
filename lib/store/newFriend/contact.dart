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
    this.contactsData = value;
  }
  // 往第一插入
  @action
  void setFirst(var value) {
    int index = 0;
    this.contactsData.insert(index, value);
  }
}
final Contact contact = Contact();