import 'package:mobx/mobx.dart';
import 'package:weichat/utils/date_util.dart';

/// 必须, 用于生成.g文件
part 'message.g.dart';
class Message = MessageMobx with _$Message;

enum MessageType { SYSTEM, PUBLIC, CHAT, GROUP }

// 聊天列表类
class MessageListItem {
  int uid;
  String nickname;
  String avatar;
  String socketId;
  String subTitle;
  String time;
  MessageType type;
  MessageListItem(this.uid, this.nickname, this.avatar, this.socketId, this.subTitle, this.time, this.type);
}

class ChatPersonDetail {
  int uid;
  String nickname;
  String avatar;
  String socketId;
}
// 聊天信息类
class Chat {
  String text;
  bool isSender; // 是否自己发送
  Chat(this.text, this.isSender);
}
abstract class MessageMobx with Store {

  // 进入聊天页面
  @action
  enterChatPage(int uid, ChatPersonDetail msg) {
    // 获取当前聊天人信息
    getCurrentMessage(msg);
    // 获取当前聊天history信息
    getCurrentChatHistory(uid);
  }
  // 退出聊天页面
  exitChatPage() {
    restCurrentChatHistory();
    restCurrentMessage();
  }
  // 发送聊天信息
  @action
  sendChatMsg(Chat msg, socket) {
    if(currentChatHistory.length == 0) {
      String t = DateUtils.getDateStrByDateTime(DateTime.now(), format: DateFormat.HOUR_MINUTE);
      addMessageList(
        MessageListItem(
          currentChatMessage.uid,
          currentChatMessage.nickname,
          currentChatMessage.avatar,
          currentChatMessage.socketId,
          msg.text,
          t,
          MessageType.CHAT,
        )
      );
    }
    // 发送聊天socket
    socket.emit('exchange', {
      'target': currentChatMessage.socketId,
      'payload': {
        'msg': msg.text,
        'uid' : currentChatMessage.uid,
        'nickname' : currentChatMessage.nickname,
        'avatar' : currentChatMessage.avatar
      },
    });
    // 更新聊天信息
    addCurrentChatHistory(msg);
  }
  // 监听接受聊天信息
  @action
  receiverChatMsg(data) {
    var payload = data['data']['payload'];
    var uid = payload['uid'];
    var msg = payload['msg'];
    // 是不是当前socketid
    if(uid == currentChatMessage.uid) {
      // 改变当前的信息
      addCurrentChatHistory(
        Chat(msg,false)
      );
    } else {
      // 改变数字角标信息
      changeBadgeCount(uid);
      // 改变总聊天的信息
      addMessageRecordMap(uid, Chat(msg,false));
    }
  }

  // ----------------------------------------------------
  // 当前聊天信息
  @observable
  ChatPersonDetail currentChatMessage;

// 聊天人列表
  @observable
  List<MessageListItem> messageList = [];

  @action
  getCurrentMessage(ChatPersonDetail msg) {
    currentChatMessage = msg;
  }
  @action
  restCurrentMessage() {
    currentChatMessage = null;
  }
  @action
  addMessageList(MessageListItem v) {
    int index = 0;
    messageList.insert(index, v);
  }
  // --------------------------------------------------

  // 当前聊天记录
  @observable
  List<Chat> currentChatHistory = [];

  // 聊天记录集合
  @observable
  Map messageRecordMap = Map<int, List<Chat>>();

  @action
  addCurrentChatHistory(Chat v) {
    currentChatHistory.add(v);
    int currentUid = currentChatMessage.uid;
    messageRecordMap[currentUid] = currentChatHistory;
  }
  @action
  addMessageRecordMap(int uid, Chat v) {
    int currentUid = currentChatMessage.uid;
    messageRecordMap[currentUid].add(v);
  }
  @action
  restCurrentChatHistory() {
    currentChatHistory = [];
  }
  @action
  getCurrentChatHistory(int uid) {
    if(messageRecordMap[uid]) {
      currentChatHistory = messageRecordMap[uid];
    } else {
      currentChatHistory = [];
    }
  }

  // --------------------------------------------------

  // 数字角标
  @observable
  Map badgeCountMap = Map<int, int>();

  // 数字角标
  @action
  changeBadgeCount(int uid) {
    badgeCountMap[uid]++;
  }

}

final Message message = Message();