import 'package:mobx/mobx.dart';
import 'package:weichat/screens/newAddFriend/NewFriendData.dart';

/// 必须, 用于生成.g文件
part 'newFriend.g.dart';
class NewFriend = NewFriendMobx with _$NewFriend;

abstract class NewFriendMobx with Store {
  /// 可观察的值
  @observable
  List<NewFriendData> newFriendData = [];

  @observable
  int newFriendDataCount = 0;

  // 设置值
  @action
  void reCount() {
    newFriendDataCount = 0;
  }

  // 设置值
  @action
  void set(var value) {
    newFriendData = value;
  }

  // 往第一插入
  @action
  void setFirst(var value) {
    newFriendDataCount = newFriendDataCount + 1;
    int index = 0;
    List<NewFriendData> cur = newFriendData;
    cur.insert(index, value);
    newFriendData = cur;
  }
}
final NewFriend newFriend = NewFriend();