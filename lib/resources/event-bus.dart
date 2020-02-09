import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class MessageEvent {
  var msg;
  MessageEvent(msg);
}

class AddFriendEvent {
  int uid;
  String nickname;
  String avatar;
  AddFriendEvent(this.uid, this.nickname, this.avatar);
}
