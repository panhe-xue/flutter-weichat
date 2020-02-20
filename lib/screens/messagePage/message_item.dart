import 'package:flutter/material.dart';
import 'package:weichat/screens/Chat/Chat.dart';
import 'package:badges/badges.dart';
import 'package:weichat/store/message/message.dart';

class MessageItem extends StatelessWidget {
  final MessageListItem messageItem;
  final int index;
  MessageItem(this.messageItem, this.index);
  Widget avatarW() {
    int uid = messageItem.uid;
    int count = message.badgeCountMap[uid];
    if(count != 0 && count != null) {
      return Badge(
        badgeContent: Text('$count', style: TextStyle(color: Colors.white)),
        badgeColor: Colors.red,
        child: new Image.network(this.messageItem.avatar, width: 40.0, height: 40.0),
      );
    } else {
      return new Image.network(this.messageItem.avatar, width: 40.0, height: 40.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: avatarW(),
        title: new Text(this.messageItem.nickname),
        subtitle: new Text(this.messageItem.subTitle),
        trailing: new Text(this.messageItem.time),
        onTap: () {
          message.enterChatPage(this.messageItem.uid, ChatPersonDetail(
            this.messageItem.uid, this.messageItem.nickname, this.messageItem.avatar, this.messageItem.socketId
          ));
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new ChatPage(index)
            )
          );
        },
      );
  }
}