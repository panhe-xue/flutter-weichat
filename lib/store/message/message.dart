import 'package:mobx/mobx.dart';
import 'package:weichat/utils/date_util.dart';
import 'package:weichat/resources/local_data_provider.dart';

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
  ChatPersonDetail(this.uid, this.nickname, this.avatar, this.socketId);
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

    badgeCountMap[currentChatMessage.uid] = 0;
  }
  // 退出聊天页面
  exitChatPage() {
    restCurrentChatHistory();
    restCurrentMessage();
  }
  // 发送聊天信息
  @action
  sendChatMsg(Chat msg, socket, index) {
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
  // 发送聊天socket
  socket.emit('exchange', {
    'target': currentChatMessage.socketId,
    'payload': {
      'msg': msg.text,
      'uid' : LocalDataProvider.getInstance().getUid(),
      'nickname' : LocalDataProvider.getInstance().getNickName(),
      'avatar' : LocalDataProvider.getInstance().getAvatar()
    },
  });
  // 更新聊天信息
  addCurrentChatHistory(msg);
  }
  // 监听接受聊天信息
  @action
  receiverChatMsg(data) {
    var payload = data['data']['payload'];
    var client = data['meta']['client'];
    var uid = payload['uid'];
    var nickname = payload['nickname'];
    var avatar = payload['avatar'];
    var msg = payload['msg'];
    // 是不是当前socketid
    if(currentChatMessage != null && uid == currentChatMessage.uid) {
      // 改变当前的信息
      addCurrentChatHistory(
        Chat(msg,false)
      );
    } else {
      // 增加消息列表
      String t = DateUtils.getDateStrByDateTime(DateTime.now(), format: DateFormat.HOUR_MINUTE);
      addMessageList(
        MessageListItem(
          uid,
          nickname,
          avatar,
          client,
          msg,
          t,
          MessageType.CHAT,
        )
      );
      // 改变数字角标信息
      changeBadgeCount(uid);
      // 改变总聊天的信息
      addMessageRecordMap(uid, Chat(msg,false));
      // 改变列表的最后信息
      messageList[0].subTitle = msg;
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
  //增加当前聊天人列表
  @action
  addMessageList(MessageListItem v) {
    if(messageList.length == 0) {
      // messageList.add(v);
      List<MessageListItem> curList = messageList;
      curList.add(v);
      messageList = curList;
    } else {
      int index = isInMessageList(v.uid);
      if(index == -1) {
        List<MessageListItem> curList = messageList;
        curList.insert(0, v);
        messageList = curList;
      } else {
        if(index != 0) {
          resetMessageList(index);
        }
      }
    }
    var c = messageList;
    messageList = c;
  }
  //根据uid判断聊天列表是否有此人
  @action
  isInMessageList(uid) {
    int index = messageList.indexWhere((MessageListItem item) => (item.uid == uid));
    return index;
  }
  @action
  resetMessageList(int index) {
    MessageListItem cur = messageList.elementAt(index);
    messageList.removeAt(index);
    messageList.insert(0, cur);
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
    List<Chat> cur = currentChatHistory;
    cur.add(v);
    currentChatHistory = cur;
    int currentUid = currentChatMessage.uid;
    messageRecordMap[currentUid] = currentChatHistory;
    // 改变列表的最后信息
    messageList[0].subTitle = v.text;
  }
  @action
  addMessageRecordMap(int uid, Chat v) {
    if(messageRecordMap[uid] == null) {
      messageRecordMap[uid] = List<Chat>();
    }
    messageRecordMap[uid].add(v);
  }
  @action
  restCurrentChatHistory() {
    currentChatHistory = [];
  }
  @action
  getCurrentChatHistory(int uid) {
    if(messageRecordMap[uid] != null) {
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
    print(badgeCountMap[uid] == null);
    if(badgeCountMap[uid] == null) {
      badgeCountMap[uid] = 0;
    }

    int curIndex = badgeCountMap[uid];
    badgeCountMap[uid] = curIndex + 1;
  }

  // ----------改变socketId-----------
  @action
  changeNewsocketId(data) {
    int uid = data['uid'];
    String socketId = data['socketId'];
    // 是不是当前uid
    if(currentChatMessage != null && uid == currentChatMessage.uid) {
      currentChatMessage.socketId = socketId;
      List<MessageListItem> cur = messageList;
      cur[0].socketId = socketId;
      messageList = cur;
    } else {
      // 改变
      int index = isInMessageList(uid);
      if(index != -1) {
        List<MessageListItem> cur = messageList;
        cur[index].socketId = socketId;
        messageList = cur;
      }
    }
  }
}

final Message message = Message();