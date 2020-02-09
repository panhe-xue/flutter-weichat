import 'package:flutter/material.dart';
import '../Chat/Chat.dart';
import 'package:date_format/date_format.dart';
import 'package:badges/badges.dart';

class MessageItem extends StatelessWidget {
  final message;
  MessageItem(this.message);
  Widget avatarW() {
    var count = message.newCount;
    if(count != 0 && count != null) {
      return Badge(
        badgeContent: Text('$count', style: TextStyle(color: Colors.white)),
        badgeColor: Colors.red,
        child: new Image.network(this.message.avatar, width: 40.0, height: 40.0),
      );
    } else {
      return new Image.network(this.message.avatar, width: 40.0, height: 40.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: avatarW(),
        title: new Text(this.message.title),
        subtitle: new Text(this.message.subTitle),
        trailing: new Text(formatDate(this.message.time, [HH, ":", nn, ":", "ss"]).toString()),
        onTap: () {
          Navigator.of(context).push(
            new MaterialPageRoute(builder: (context) {
              return new Chat();
            })
          );
        },
      );
  }
}