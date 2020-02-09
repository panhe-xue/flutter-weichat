import 'package:flutter/material.dart';
import './Chat_vo.dart';

class EntryItem extends StatelessWidget {
  final Message message;
  // final Chatter chatter;
  EntryItem(this.message);

  Widget row() {
    if(message.isSender) {
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
                    message.text,
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
            margin: const EdgeInsets.only(left: 12.0,right: 12.0),
            child: new CircleAvatar(
              backgroundImage: AssetImage("images/lebron.jpg"),
              radius: 24.0,
            ) ,
          ),
        ]
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          new Container(
            margin: const EdgeInsets.only(left: 12.0,right: 12.0),
            child: new CircleAvatar(
              backgroundImage: AssetImage("images/a002.jpg"),
              radius: 24.0,
            ) ,
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
                    message.text,
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