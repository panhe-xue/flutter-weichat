enum MessageType { SYSTEM, PUBLIC, CHAT, GROUP }

class MessageData {
  String nickname;
  String socketId;
  String title;
  String subTitle;
  DateTime time;
  MessageType type;
}