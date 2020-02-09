enum MessageType { SYSTEM, PUBLIC, CHAT, GROUP }

class MessageData {
  String socketId;
  String avatar;
  String title;
  String subTitle;
  DateTime time;
  int newCount;
  MessageType type;
  // MessageData(this.socketId, this.avatar, this.title, this.subTitle, this.time, this.newCount, this.type);
}