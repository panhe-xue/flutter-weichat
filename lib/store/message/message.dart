import 'package:mobx/mobx.dart';

/// 必须, 用于生成.g文件
part 'message.g.dart';
class Message = MessageMobx with _$Message;

abstract class MessageMobx with Store {
  // 可观察的值
  @observable
  var messageData = [];

  // 设置值
  @action
  void set(var value) {
    this.messageData = value;
  }
  // 增加值
  @action
  void add(var value) {
    this.messageData.add(value);
  }
}
final Message message = Message();