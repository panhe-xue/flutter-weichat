import 'package:flutter/material.dart';
import 'package:weichat/store/message/message.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weichat/resources/local_data_provider.dart';

class EntryItem extends StatelessWidget {
  final Chat _message;
  // final Chatter chatter;
  EntryItem(this._message);

  Widget row() {
    if(_message.isSender) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                  ),
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    _message.text,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                  ),
                ),
              ],
            )
          ),
          new Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(left: 12.0,right: 12.0),
            child: Image.network(LocalDataProvider.getInstance().getAvatar()),
          ),
        ]
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          new Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(left: 12.0,right: 12.0),
            child: Image.network(message.currentChatMessage.avatar),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                  ),
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    _message.text,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                  ),
                )
              ],
            )
          )
        ]
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: row()
    );
  }
}