import 'package:flutter/material.dart';
import './EntryItem.dart';
import './Chat_vo.dart';

class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChatState();
  }
}

class ChatState extends State<Chat> {

  @override
  Widget build(BuildContext context){
    final TextEditingController _textController = TextEditingController();
    void _handleSubmitted() {
      var text = _textController.text;
      _textController.clear();
      print(text);
      // IOClient.sendMsg(MessageBean(target, text));
    }
    Widget _buildTextComposer() {
      return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: _textController,
              decoration: new InputDecoration.collapsed(hintText: '发送消息')
            ),
          ),
          new Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon(Icons.send, color: Colors.blue),
              onPressed: () {
                _handleSubmitted();
              },
            )
          )
        ])
      );
    }

    Widget divider = Divider(color: Color(0xFFebebeb), height: 18.0, indent: 18);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("佩询"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFebebeb)
        ),
        child: new Column(children: <Widget>[
          new Flexible(
            child: new ListView.separated(
              separatorBuilder: (BuildContext context, index) {
                return divider;
              },
              padding: new EdgeInsets.all(8.0),
              // reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return EntryItem(message[index]);
              },
              itemCount: message.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          )
        ]),
      )
    );
  }
}