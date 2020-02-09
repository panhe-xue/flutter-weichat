import 'package:mobx/mobx.dart';

/// 必须, 用于生成.g文件
part 'newFriend.g.dart';
class NewFriend = NewFriendMobx with _$NewFriend;

abstract class NewFriendMobx with Store {
  /// 可观察的值
  @observable
  List newFriendData = [];

  @observable
  int newFriendDataCount = 0;

  // 设置值
  @action
  void reCount() {
    this.newFriendDataCount = 0;
  }

  // 设置值
  @action
  void set(var value) {
    this.newFriendData = value;
  }

  // 往第一插入
  @action
  void setFirst(var value) {
    newFriendDataCount++;
    int index = 0;
    this.newFriendData.insert(index, value);
  }
}
final NewFriend newFriend = NewFriend();