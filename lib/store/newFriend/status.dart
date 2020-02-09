import 'package:mobx/mobx.dart';

/// 必须, 用于生成.g文件
part 'status.g.dart';
class Status = StatusMobx with _$Status;

abstract class StatusMobx with Store {
  /// 可观察的值
  @observable
  int status = 0;

  /// 设置值
  @action
  void set(int value) {
    this.status = value;
  }
}